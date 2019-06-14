function DoMarsGraphics(k);
global XTrue;global Store;global Params;

t = [1:k-1]*Params.dT;

figure(1);
subplot(2,2,1);
plot(t,XTrue(1,:),'b:');hold on;
plot(t,Store.XEst(1,:),'r');
title('True and Estimated Trajectories');
ylabel('Altitude (m)');
axis tight;

subplot(2,2,3);
plot(t,XTrue(2,:)*3.6,'b:');hold on;
plot(t,Store.XEst(2,:)*3.6,'r');
ylabel('Velocity (km/h)')
xlabel('time (s)');
title(sprintf('Chute @ %.1f, Rockets @ %.1f, Lands @ %.1f',...
    Params.ChuteTime,Params.BurnTime,Params.LandingTime));
axis tight;

XError = XTrue-Store.XEst;
subplot(2,2,2);
plot(t,XError(1,:));hold on;
plot(t,-sqrt(Store.PEst(1,:)),'r--');
plot(t,sqrt(Store.PEst(1,:)),'r--');
title('Trajectories Error (XEst-XTrue)');
%fit axes
ca = axis;
ca(3) = -4*mean(sqrt(Store.PEst(1,:)));
ca(4) = -ca(3);
axis(ca);


subplot(2,2,4);
plot(t,XError(2,:));hold on;
plot(t,-sqrt(Store.PEst(2,:))*3.6,'r--');
plot(t,sqrt(Store.PEst(2,:))*3.6,'r--');
axis tight;
%ylabel('Altitude (m)');
xlabel('time (s)');
%fit axes
ca = axis;
ca(3) = -4*mean(sqrt(Store.PEst(2,:)));
ca(4) = -ca(3);
axis(ca);
print -depsc 'MarsTrajectory.eps'



figure(2);
subplot(2,1,1);hold on;
title('Observations');
xlabel('time');
ylabel('Measurement (time of flight seconds)');
plot(t,Store.z);hold on;
axis tight;

subplot(2,1,2);hold on;
title('Innovation Sequence');
xlabel('time');
ylabel('Innovation (time of flight seconds)');
plot(t,Store.Innovation);hold on;
plot(t,-sqrt(Store.S),'r--');
plot(t,sqrt(Store.S),'r--');
%fit axes
ca = axis;
ca(3) = -4*mean(sqrt(Store.S));
ca(4) = -ca(3);
axis(ca);

print -depsc 'MarsInnov.eps'
