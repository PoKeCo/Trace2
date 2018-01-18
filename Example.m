s_len=80;
dt=0.1;
static=zeros(s_len,2);
figure(1);
clf(1);
hold on;
for l=-1:+1    
    for s=1:s_len
        static(s,:)=[(s-1),l*5.0+2.5*cos( 0.5*pi*(s-1)/s_len )];
    end
    plot( static(:,1), static(:,2), '.-r' );
    axis equal;
end

prv1=[-1,0];
%prv2=[70,3];
prv2=[60,30];
j=1;
col='cmyrgbk';
for i=0:10:50
    t=i*dt;
    s=30/3.6*t;    
    blur=1.0+i/50*0.5;
    %Car1
    s1=s+20.0
    pos1=[(s1),-2.5+2.5*cos( 0.5*pi*(s1-1)/s_len )];
    th1=-atan2(pos1(2)-prv1(2),pos1(1)-prv1(1));
    car1=DrawCar([pos1,th1+pi],[5,2],blur)
    plot(car1(:,1),car1(:,2),['.-',col(j)]);
    prv1=pos1;
    
    %Car2
    ss=55-s;
    %pos2=[(ss),5.0-2.5+2.5*cos( 0.5*pi*(ss-1)/s_len )];
    tha=s/s_len*pi/2;
    pos2=[20+30*cos(-tha-pi/4),35+30*sin(-tha-pi/4)];
    th2=-atan2(pos2(2)-prv2(2),pos2(1)-prv2(1));
    car2=DrawCar([pos2,th2],[5,2],blur)
    plot(car2(:,1),car2(:,2),['.-',col(j)]);
    prv2=pos2;
    
    j=j+1;
end
