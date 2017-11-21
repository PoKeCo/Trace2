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
% Mix New Trajectory and Destination Trajectory
Ct=[ct;0]-[0;ct]+[0;tt]
yC=B*C;
yCt=B*Ct;
%plot(a,y,'.',a,yy,'o',a,yt,'*',a,yyyt,'x');
plot(a,y,'.',a,yt,'*',a,yyyt,'x',a,yC,'.-r',a,yCt,'o-b');




