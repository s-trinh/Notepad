%--------------------------------------------------
% A MARS LANDER --- EXAMPLE CODE C4                   
% P. Newman 2003                                        
%--------------------------------------------------  


%---------  TOP LEVEL LOOP ---------------------%
function SimulateMarsLander
close all;clear all;

global Params;global XTrue;global VehicleStatus;global Store;

%set up parameters
DoInitialise;

%initial conditions of estimator
XEst  = [Params.X0+Params.InitialHeightError;Params.V0+Params.InitialVelocityError]; 
PEst = diag([Params.InitialHeightStd^2, Params.InitialVelocityStd^2]); 

%store initial conditions:
DoStore(1,XEst,PEst,[0],[0],NaN);

k = 2;
while(~VehicleStatus.Landed & k <Params.StopTime/Params.dT)
            
    % simulate the world
    DoWorldSimulation(k);
                
    % read from sensor
    z(k) = GetSensorData(k);
        
    % estimate the state of the vehicle
    [XEst,PEst,S,Innovation] = DoEstimation(XEst,PEst,z(k));
        
    % make decisions based on our esimated state
    DoControl(k,XEst);
                  
    % store results 
    DoStore(k,XEst,PEst,Innovation,S,z(k));
        
    %tick...
    k = k+1;    
end;

%draw pictures....
DoMarsGraphics(k);

return;

%---------  PROBLEM SET UP AND INITIALISATION ---------------------%
% users changes parameters here 
function DoInitialise
global Params;
global XTrue;
global VehicleStatus;
global Store;

%------ user configurable parameters -------------
Params.StopTime = 600;%run for how many seconds (maximum)?
Params.dT = 0.1; % Run navigation at 10Hz
Params.c_light = 2.998e8;
Params.EntryDrag = 5;                       % linear drag constant
Params.ChuteDrag = 2.5*Params.EntryDrag;      % linear drag constant with chute open
Params.g = 9.8/3;  % assumed gravity on mars
Params.m = 50;     % mass of vehcile
Params.RocketBurnHeight = 1000;  % when to turn on brakes
Params.OpenChuteHeight = 4000;   %when to open chute
Params.X0 = 10000; % true entry height 
Params.V0 = 0;     % true entry velocity
Params.InitialHeightError = 0; % error on  entry height 
Params.InitialVelocityError = 0; % error on entry velocity
Params.InitialHeightStd = 100;  %uncertainty in initial conditions
Params.InitialVelocityStd = 20; %uncertainty in initial conditions
Params.BurnTime = NaN;
Params.ChuteTime = NaN;
Params.LandingTime = NaN;

%initial vehicle condition at entry into atmosphere...
VehicleStatus.ChuteOpen = 0;
VehicleStatus.RocketsOn = 0;
VehicleStatus.Drag = Params.EntryDrag;
VehicleStatus.Thrust = 0;
VehicleStatus.Landed = 0;

%process plant model (constant velcoity with noise in acceleration)
Params.F = [1 Params.dT;
             0 1];

%process noise model (maps acceleration noise to other states)
Params.G = [Params.dT^2/2 ;Params.dT];

%actual process noise truely occuring - atmospher entry is a bumpy business
%note this noise strength - not the deacceleration of the vehicle....
Params.SigmaQ = 0.2; %ms^{-2}

%process noise strength how much acceleration (varinace) in one tick
% we expect (used to 'explain' inaccuracies in our model)
%the 3 is scale factor (set it to 1 and real and modelled noises will
%be equal
Params.Q = (1.1*Params.SigmaQ)^2; %(ms^2 std)

%observation model (explains observations in terms of state to be estimated)
Params.H = [2/Params.c_light 0];

%observation noise strength (RTrue) is how noisey the sensor really is
Params.SigmaR = 1.3e-7; %(seconds) 3.0e-7 corresponds to around 50m error....

%observation expected noise strength (we never know this parameter exactly)
%set the scale factor to 1 to make model and reallity match
Params.R = (1.1*Params.SigmaR)^2;

%initial conditions of (true) world:
XTrue(:,1) = [Params.X0;Params.V0];

Params
return;

%------------------ MEASUREMENT SYSTEM ------------------%
function z = GetSensorData(k)
global XTrue;
global Params;
    z =  Params.H*XTrue(:,k) + Params.SigmaR* randn(1);
return;

%--------------- ESTIMATION KALMAN FILTER ---------------%
function [XEst,PEst,S,Innovation] = DoEstimation(XEst,PEst,z)
global Params;
F = Params.F;G = Params.G;Q = Params.Q;R = Params.R;H = Params.H;

%prediction...
XPred = F*XEst;
PPred = F*PEst*F'+G*Q*G';

% prepare for update...
Innovation = z-H*XPred;
S = H*PPred*H'+R;
W = PPred*H'*inv(S);

% do update....
XEst = XPred+W*Innovation;
PEst = PPred-W*S*W';
return;

%--------------- ITERATE SIMULATION -----=---------------%
function DoWorldSimulation(k)

global XTrue;global Params;global VehicleStatus;

oldvel = XTrue(2,k-1);
oldpos = XTrue(1,k-1);
dT = Params.dT;

%friction is a function of height
cxtau = 500; % spatial exponential factor for atmosphere density)
AtmospherDensityScaleFactor = (1-exp(-(Params.X0-oldpos)/cxtau) );
c = AtmospherDensityScaleFactor*VehicleStatus.Drag;

%clamp between 0 and c for numerical safety
c = min(max(c,0),VehicleStatus.Drag);

%simple Euler integration
acc = (-c*oldvel- Params.m*Params.g+VehicleStatus.Thrust)/Params.m + Params.SigmaQ*randn(1);
newvel = oldvel+acc*dT;
newpos = oldpos+oldvel*dT+0.5*acc*dT^2;
XTrue(:,k) = [newpos;newvel];



%--------------- LANDER CONTROL -------------------------%

function DoControl(k,XEst)

global Params;global VehicleStatus;

if(XEst(1)<Params.OpenChuteHeight & ~VehicleStatus.ChuteOpen)
    %open parachute:
    VehicleStatus.ChuteOpen = 1;
    VehicleStatus.Drag = Params.ChuteDrag;
    fprintf('Opening Chute at time %f\n',k*Params.dT);
    Params.ChuteTime = k*Params.dT;
end;

if(XEst(1)<Params.RocketBurnHeight )
    if(~VehicleStatus.RocketsOn)
        fprintf('Releasing Chute at time %f\n',k*Params.dT);
        fprintf('Firing Rockets at time %f\n',k*Params.dT);
        Params.BurnTime = k*Params.dT;
    end;

    %turn on thrusters    
    VehicleStatus.RocketsOn = 1;
    
    %drop chute..
    VehicleStatus.Drag = 0;
    
    %simple littel controller here (from v^2 = u^2+2as) and +mg for weight of vehicle
    VehicleStatus.Thrust = (Params.m*XEst(2)^2-1)/(2*XEst(1))+0.99*Params.m*Params.g;
    
end;

if(XEst(1)<1)
    %stop when we hit the ground...
    fprintf('Landed at time %f\n',k*Params.dT);
    VehicleStatus.Landed = 1;
    Params.LandingTime = k*Params.dT;
    break;
end;

return;

%--------------- MANAGE RESULTS STORAGE ----------------------%
function DoStore(k,XEst,PEst,Innovation,S,z)
global Store;
if(k==1)
    Store.XEst  = XEst;
    Store.PEst  = diag(PEst);
    Store.Innovation = Innovation;
    Store.S = S;
    Store.z = z;
    
else
    Store.XEst = [Store.XEst XEst];
    Store.PEst  = [Store.PEst diag(PEst)];
    Store.Innovation = [ Store.Innovation Innovation];
    Store.S = [Store.S diag(S)];
    Store.z = [Store.z z];

end;
return;




