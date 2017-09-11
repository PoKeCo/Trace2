%SimRun2
SimCnt=101;
           %( x, y, th,   dlt,        v,   a, j, L, W, WB );
car=CarInit ( 5, -5,  0.0,   0.0, 30/3.6, 0.0, 0, 4.5, 1.9, 4.0 );

ary=zeros(SimCnt,3);

road=[-20,0
       50,0
       90,20
       140,20];

prdcar=CarRun(car);
figure(1);
clf(1);
hold on;
axis equal;
for L=10:20:100
    [s,e,crop_path]=GetAhead(road,[car.x,car.y],L);

    plot(road(:,1),road(:,2),'.-',...
        car.x,car.y,'*',...
        s(1),s(2),'ob',...
        e(1),e(2),'og',...
        crop_path(:,1),crop_path(:,2),'.-g'  );%,...


    Curve=GetCurve([car.x,car.y,car.th],e,road);
    plot(Curve(:,1),Curve(:,2),'.-m');
end
