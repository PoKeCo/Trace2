%SimRun2


SimCnt=201;
           %( x, y, th,   dlt,        v,   a, j, L, W, WB );
car=CarInit ( 0, 0,  0.0,   0.0, 30/3.6, 0.0, 0, 4.5, 1.9, 4.0 );
%car=CarInit ( 40, -34,  0.0,   0.0, 30/3.6, 0.0, 0, 4.5, 1.9, 4.0 );

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
road=GetPathExampleCorner(500,20,75,10);

prdcar=CarRun(car);
figure(1);
clf(1);
hold off;
axis equal;
%for L=10:1:Lsum
hist_cnt=450;
hist=zeros(hist_cnt,7);
v=30/3.6;
L=5*v;
for i=1:hist_cnt
    [s,e,crop_path]=GetAhead(road,[car.x,car.y],L);
    e=[e,0];
    
    
    %Curve=GetCurveK([car.x,car.y,car.th,car.dlt/car.WB],e,road);    
    %hist(i,:)=Curve(1,:);
    hist(i,1:5)=[car.x, car.y,car.th,car.dlt/car.WB,car.ddlt];%Curve(1,:);
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
    tmp1=crop_path(1,1:2);
    tmp2=crop_path(2,1:2);

    dlt_th=ref_th-car.th;    

    if( dlt_th > pi )
        dlt_th = dlt_th - 2*pi;
    elseif( dlt_th < -pi )
        dlt_th = dlt_th + 2*pi;
    end
    
    [ref_th,car.th,0,dlt_th]*180/pi;
    dest_dlt=(1*dlt_th/car.v/car.dt + 1*err)*1.0;
    if( dest_dlt > pi )
        dest_dlt = dest_dlt - 2*pi;
    elseif( dest_dlt < -pi )
        dest_dlt = dest_dlt + 2*pi;
    end
    hist(i,6:7)=[car.dlt*180/pi,car.ddlt];%Curve(1,:);    
    
    car.dlt=dest_dlt;
    %dlt_ddlt=car.ddlt*0.0+1.0*(dest_dlt-car.dlt)/car.dt;
    %car.ddlt=dlt_ddlt;
    %car.ddlt=max(-pi/3,min(+pi/3,dlt_ddlt));    
    
    car.dlt=max(-pi/6,min(pi/6,car.dlt));
    
    %op=OfsPath( Curve(:,1:2), Curve(:,4) ); 
    
    figure(1);
    plot(road(:,1),road(:,2),'.-',...
        car.x,car.y,'*',...
        s(1),s(2),'ob',...
        e(1),e(2),'og',...
        crop_path(:,1),crop_path(:,2),'.-g',...
        hist(1:i,1),hist(1:i,2),'.-r' );
    hold on;
    plot( [car.x, car.x+20*cos(car.th)],[car.y,car.y+20*sin(car.th)],'o-r',...
          [car.x, car.x+20*cos(ref_th)],[car.y,car.y+20*sin(ref_th)],'.-b' );
    %plot(Curve(  :,1),Curve(  :,2),'.-m',...
    %     op( :,1),op(:,2),'.-c',...
    %     Curve(end,1),Curve(end,2),'or');
    hold off;
    axis equal;
    
    figure(2);
    plot(1:i,hist(1:i,5),'.-',...
         1:i,hist(1:i,4),'.-'  );
    
    if( tmp1==tmp2 )
        crop_path
        tmp1
        tmp2
        ref_th
        pause
    end
    
    car=CarRun(car);   
    
    pause(0.05);
%end
end