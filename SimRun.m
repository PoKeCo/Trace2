%Main
           
           
SimCnt=101;
           %( x, y, th,   dlt,        v,   a, j, L, W, WB );
car=CarInit ( 0, -2,  0.2,   0.0, 30/3.6, 0.0, 0, 4.5, 1.9, 4.0 );

ary=zeros(SimCnt,3);
road=[-10,0
       30,0
       60,10
       90,10];

for i=1:SimCnt
    t=(i-1)*car.dt;
    
    ary(i,:)=[t,car.x, car.y];
    prdcar=car;
    for ii=1:11
        prdcar=CarRun(prdcar);        
    end    
    [r,d]=GetNearest(road,[prdcar.x,prdcar.y]);
    cxy=[cos(prdcar.th),-sin(prdcar.th);
         sin(prdcar.th), cos(prdcar.th)]*(r-[prdcar.x,prdcar.y])';
    figure(2);    
    plot(cxy(1),cxy(2),'*',...
         0,0,'o');
    axis ([-5,5,-5,5]);
    axis equal;
    
    car.ddlt = 0.2*cxy(2);
    
    car=CarRun(car);
    figure(1);
    plot( ary (:,2),  ary(:,3), '.-',...
          road(:,1), road(:,2), '.-',...
          r(1)     , r(2)     , '*',...
          prdcar.x , prdcar.y , 'o'    );
    axis equal;
    
    pause(1/30);
end