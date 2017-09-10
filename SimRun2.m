%SimRun2
SimCnt=101;
           %( x, y, th,   dlt,        v,   a, j, L, W, WB );
car=CarInit ( -5, -5,  0.2,   0.0, 30/3.6, 0.0, 0, 4.5, 1.9, 4.0 );

ary=zeros(SimCnt,3);

road=[-10,0
       30,0
       60,10
       90,10];

prdcar=CarRun(car);
figure(1);
clf(1);
hold on;
axis equal;
[s,e,crop_path]=GetAhead(road,[car.x,car.y],20+40*0+30*0);

plot(road(:,1),road(:,2),'.-',...
    car.x,car.y,'*',...
    s(1),s(2),'ob',...
    e(1),e(2),'og',...
    crop_path(:,1),crop_path(:,2),'.-g'  );%,...

quiver([s(1),e(1)],[s(2),e(2)],...
       [1*cos(s(3)+0.0),1*cos(e(3)+0.0)],...
       [1*sin(s(3)+0.0),1*sin(e(3)+0.0)]);

Curve=GetCurve([car.x,car.y,car.th],e);
plot(Curve(:,1),Curve(:,2),'.-m');

