%SimRun2


SimCnt=201;
           %( x, y, th,   dlt,        v,   a, j, L, W, WB );
car=CarInit ( 0, -10,  0.0,   0.0, 30/3.6, 0.0, 0, 4.5, 1.9, 4.0 );

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

%road=GetPathExample(500);
road=GetPathExampleCorner(500,20,75,1);

prdcar=CarRun(car);
figure(1);
clf(1);
hold off;
axis equal;
%for L=10:1:Lsum
hist_cnt=450;
hist=zeros(hist_cnt,4);
v=30/3.6;
L=5*v;
for i=1:hist_cnt
    [s,e,crop_path]=GetAhead(road,[car.x,car.y],L);
    e=[e,0];
    figure(1);    
    Curve=GetCurveK([car.x,car.y,car.th,car.dlt/car.WB],e,road);    
    hist(i,:)=Curve(1,:);
    %car.x  =Curve(2,1);
    %car.y  =Curve(2,2);
    %car.a  =0;
    car.v  =v;
    %car.th =Curve(2,3);
    %Curve(2,4)*car.WB
    %car.dlt=max(-pi/6,min(pi/6,Curve(2,4)*car.WB));
    %car.x=crop_path(2,1);
    %car.y=crop_path(2,2);
    
    err=-( crop_path(2,1)-car.x )*sin(car.th) ...
        +( crop_path(2,2)-car.y )*cos(car.th)  ;
    
    ref_th=atan2( crop_path(2,2)-crop_path(1,2), crop_path(2,1)-crop_path(1,1));
    dlt_th=ref_th-car.th;
    dlt_th*180/pi
    if(dlt_th>pi)
        dlt_th=dlt_th-2*pi;
    elseif(dlt_th<-pi)
        dlt_th=dlt_th+2*pi;
    end
    car.dlt=max(-pi/6,min(pi/6,(ref_th-car.th)/car.v/car.dt + 0.4*err));%(crop_path(2,2)-car.y)*0.1;
    %car.dlt=Curve(2,4)*car.WB
    %car.dlt=0;
    %car.ddlt=0;
    

    op=OfsPath( Curve(:,1:2), Curve(:,4) ); 
    figure(1);
    plot(road(:,1),road(:,2),'.-',...
        car.x,car.y,'*',...
        s(1),s(2),'ob',...
        e(1),e(2),'og',...
        crop_path(:,1),crop_path(:,2),'.-g',...
        hist(1:i,1),hist(1:i,2),'.-r' );
    hold on;
    plot(Curve(  :,1),Curve(  :,2),'.-m',...
         op( :,1),op(:,2),'.-c',...
         Curve(end,1),Curve(end,2),'or');
    hold off;
    axis equal;
    
    car=CarRun(car);   
    
    pause(0.05);
%end
end