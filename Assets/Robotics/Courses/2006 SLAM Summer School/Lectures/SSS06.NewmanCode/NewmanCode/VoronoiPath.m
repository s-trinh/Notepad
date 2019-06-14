% plot voronoi diagram for path planning:
clear all;
close all;
nF = 100;
Map = 100*rand(nF,2)
[Vx,Vy] = voronoi(Map(:,1),Map(:,2));

plot(Vx,Vy,'b-',Map(:,1),Map(:,2),'r.');
axis equal;
axis([0 100 0 100]);