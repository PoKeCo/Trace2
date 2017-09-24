%SimRun2
SimCnt=101;
           %( x, y, th,   dlt,        v,   a, j, L, W, WB );
car=CarInit ( -10, -10,  0.0,   0.0, 30/3.6, 0.0, 0, 4.5, 1.9, 4.0 );

ary=zeros(SimCnt,3);

%road=[0,0
%     50,0
%     90,50
%     300,-0];
KLEN=10;
road=zeros(KLEN,2);   
Lsum=0;
for k=2:KLEN     
    road(k,:)=[road(k-1,1) + 50*rand(), 10*randn() ];
    Lsum=Lsum+norm(road(k,:)-road(k-1,:));
end

prdcar=CarRun(car);
figure(1);
clf(1);
hold off;
axis equal;
for L=10:1:Lsum
    [s,e,crop_path]=GetAhead(road,[car.x,car.y],L);
    figure(1);


    Curve=GetCurve([car.x,car.y,car.th],e,road);
    figure(1);
    plot(road(:,1),road(:,2),'.-',...
        car.x,car.y,'*',...
        s(1),s(2),'ob',...
        e(1),e(2),'og',...
        crop_path(:,1),crop_path(:,2),'.-g'  );%,...
    hold on;
    plot(Curve(  :,1),Curve(  :,2),'.-m',...
         Curve(end,1),Curve(end,2),'or');
    hold off;
    axis equal;
    pause(0.05);
end
