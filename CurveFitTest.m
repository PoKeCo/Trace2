%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Pseudo Inverse Test

%ct=[1;2;2;-3];
ct=randn(4,1);
%tt=[2;1;1;0];
tt=randn(4,1);
a_size=100;
a_step=1/(a_size-1);
a=[0:a_step:1]';
A=[ones(a_size,1),a,a.^2,a.^3];
y=A*ct;
c=pinv(A)*y;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slide Next 'da'
da=a_step*20;
cn=[1, da, da^2,   da^3;
    0,  1, 2*da, 3*da^2;
    0,  0,    1, 3*da  ;
    0,  0,    0,      1]*ct;
yy=A*cn;
yt=A*tt;

yyyt=y.*(1-a)+yt.*a;

B=[ones(a_size,1),a,a.^2,a.^3,a.^4];
C=pinv(B)*yyyt

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mix New Trajectory and Destination Trajectory
Ct=[ct;0]-[0;ct]+[0;tt]
yC=B*C;
yCt=B*Ct;
figure(1);
%plot(a,y,'.',a,yy,'o',a,yt,'*',a,yyyt,'x');
plot(a,y,'.',a,yt,'*',a,yyyt,'x',a,yC,'.-r',a,yCt,'o-b');
%    x, y, th, dlt, v, a, j, L, W, WB
car=CarInitAccord(0,0,0,0,30/3.6,0,0,5);
car_hist=zeros(100,4);
for i=1:100
    car.dlt=pi/10*sin(i/100*2*pi);
    car_hist(i,:)=[car.x,car.y,car.th,car.dlt/car.WB];    
    car=CarRun(car);    
end
figure(2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fit CarCurveModel to spline

f=pinv(A)*car_hist(:,1:2);
fy=A*f;
plot(car_hist(:,1), car_hist(:,2), '.',fy(:,1),fy(:,2),'x');
axis equal;
