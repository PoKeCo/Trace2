%SimRun2


SimCnt=201;
           %( x, y, th,   dlt,        v,   a, j, L, W, WB );
car=CarInitAccord ( 0, 0,  0.0,   0.0, 30/3.6, 0.0, 0);
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
%road=GetPathExampleCorner(500,14,75,0);
road=GetPathExampleCorner(500,16,75,0);
%road=GetPathExampleCorner(500,24,75,0);
%road=GetPathExampleCorner(500,30,75,7);

car4c=CarInitAccord ( 0, 0,  0.0,   0.0, 30/3.6, 0.0, 0);
CrvEst=GetCurveture(road,car4c);
%figure(6);
%t=size(CrvEst,1);plot(1:t,CrvEst(:,4),'.-');

prdcar=CarRun(car);
figure(1);
clf(1);
hold off;
axis equal;
%for L=10:1:Lsum
hist_cnt=450;
hist=zeros(hist_cnt,16);
v=60/3.6;
L=5*v;
L=20;

for i=1:hist_cnt
    %vdst=60/3.6 * i/hist_cnt;

    [s,e,crop_path]=GetAhead(road,[car.x,car.y],L);
    CrvEst=GetCurveture(crop_path,car4c);
    
    VPat=GetVPattern(CrvEst,120/3.6,0.2*9.8,0.2*9.8);
    
    %figure(7);
    %t=size(CrvEst,1);plot(1:t,CrvEst(:,4),'.-' );
    figure(8);
    t=size(CrvEst,1);plot(1:t,VPat*3.6,'.-' );    
        
    e=[e,0];
    
    hist(i,1:5)=[car.x, car.y,car.th,car.dlt/car.WB,car.ddlt];%Curve(1,:);
    
    dT=0.1;
    a =9.8*0.3;
    
    %car.v  = min( [VPat(1,1), car.v + dT*a , 60/3,6] );
    %vdst= min( [VPat(10,1), car.v + dT*a , 30/3.6] );
    vdst= min( [VPat(10,1), 30/3.6] );
    car.a = max(-0.2*9.8, min(+0.2*9.8,car.a * 0.0 + 0.5*(vdst-car.v)/dT));
    %car.v = vdst;
    
    
    R = car.WB/(car.WB*0.01+abs(car.dlt));   

    err=-( crop_path(2,1)-car.x )*sin(car.th) ...
        +( crop_path(2,2)-car.y )*cos(car.th)  ;
    
    ref_th=atan2( crop_path(2,2)-crop_path(1,2), crop_path(2,1)-crop_path(1,1));
    dlt_th=ref_th-car.th;    

    if( dlt_th > pi )
        dlt_th = dlt_th - 2*pi;
    elseif( dlt_th < -pi )
        dlt_th = dlt_th + 2*pi;
    end    
    
    dest_dlt=(1*dlt_th/car.v/car.dt + 1*err)*1.0;
    if( dest_dlt > pi )
        dest_dlt = dest_dlt - 2*pi;
    elseif( dest_dlt < -pi )
        dest_dlt = dest_dlt + 2*pi;
    end
    hist(i,6:7)=[car.dlt*180/pi,car.ddlt];%Curve(1,:);    
    
    hist(i,8)=[car.v*car.v*car.dlt/car.WB];
        
    car.dlt=dest_dlt;    
    car.dlt=max(-pi/6,min(pi/6,car.dlt));
    
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
    hold off;
    axis equal;
    
    %figure(2);
    %plot(1:i,hist(1:i,5),'r.-',...
    %     1:i,hist(1:i,4),'g.-' );
    
    %figure(3);
    %plot(1:i,hist(1:i,8)/9.8,'g.-'   );    
          
    figure(4);
    hist(i,9)=car.v;
    hist(i,13)=vdst;
    plot(1:i,hist(1:i,9)*3.6,'g.-',...
         1:i,hist(1:i,13)*3.6,'b.-'  );
    
    %figure(5);
    %hist(i,10)=R;
    %plot(1:i,hist(1:i,10),'g.-'   );        
     
    figure(6);
    hist(i,14)=car.v*car.v/R/9.8;
    plot(1:i,hist(1:i,14),'g.-'   );       
    
    
    figure(7);title('car.dlt');
    hist(i,15)=car.dlt;
    plot(1:i,hist(1:i,15)*180/pi,'g.-'   );       
    
        
    figure(9);
    hist(i,16)=car.a;
    plot(1:i,hist(1:i,16),'b.-'   );    
    
    car=CarRun(car);   
    
    pause(0.1);
%end
end