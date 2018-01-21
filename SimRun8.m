%SimRun2


SimCnt=201;
car=CarInitAccord ( -0, -4,  -00*pi/180,   0.0, 32/3.6, 0.0, 0);
road=GetPathExampleCorner(300,12,75,0);
%CrvEst=GetCurveture(road,car4c);

vdst=60/3.6;

for f=1:2
    figure(f);
    clf(f);    
end

%for L=10:1:Lsum
hist_cnt=300;
hist=zeros(hist_cnt,16);
car.v=vdst;


for i=1:hist_cnt
    %car.v = 30/3.6;%*(1.2+sin(i/10*car.dt*2*pi));
    L=0.0+1.0*car.v;
    [s,e,crop_path]=GetAheadOth(road,[car.x,car.y,car.th],L);
    shape = DrawCar( [car.x, car.y, -car.th], [car.L, car.W], 1.0  );
    k=sin(car.dlt)/car.L;
    hist(i,1:7)=[car.x,car.y,car.th,k,car.v*car.v*k,car.a,car.v];
%   CrvEst=GetCurveture(crop_path,car4c);
%   VPat=GetVPattern(CrvEst,120/3.6,0.2*9.8,0.2*9.8);
    local_path=GetLocal(crop_path,car);
    local_shape = DrawCar( [0, 0, 0], [car.L, car.W], 1.0  );
    nxt=local_path(end,:);
    %Method 1.0
    %car.dlt=max(-car.dltLim,min(+car.dltLim,( atan2(nxt(2),nxt(1)) )));
    %Method 1.5
    %car.dlt=asin( atan2(nxt(2),nxt(1))*car.L/car.dt/car.v);
    %car.dlt=atan2(nxt(2),nxt(1));
    %Method 2.0
    %car.dlt=asin( 2*nxt(2)*car.L/(nxt(1)^2+nxt(2)^2));
    %Method 3.0
    ksum=0;
    kcnt=0;
    %for j=(size(local_path,1)-7):size(local_path,1)
    
    %for j=4:size(local_path,1)
    %    ksum=ksum+2*local_path(j,2)/(local_path(j,1)^2+local_path(j,2)^2);
    %    kcnt=kcnt+1;
    %end    
    
    %k=ksum/kcnt;
    k=2*nxt(2)/(nxt(1)^2+nxt(2)^2);
    refdlt=asin( k*car.L );
        
    if( k~=0 )
        %9.8*0.3=car.v*car.v*k;
        refv=min( vdst, sqrt(9.8*0.3/abs(k)) );
    else
        refv=vdst;
    end
    refv*3.6    
    car.a=(refv-car.v)/car.dt * 0.125;
    %Method 3
    %LL=sqrt(nxt(1)^2+nxt(2)^2);
    %sin_alpha=nxt(2)/LL;
    %car.dlt=atan2(2*car.L*sin_alpha,LL);
    
    % dlt Limitter
    refdlt=max(-car.dltLim,min(+car.dltLim,( refdlt )));
    
    car.ddlt=(refdlt-car.dlt)*1.0/car.dt;
    ddltLim=90/car.StLim*car.dltLim/car.dt;
    car.ddlt=max(-ddltLim,min(+ddltLim,car.ddlt));
    
    figure(1);
    plot( road(:,1)     , road(:,2)     , '.-b', ...
          crop_path(:,1), crop_path(:,2), '.-g', ...
          shape(:,1)    , shape(:,2)      , '+-r', ...  
          hist(1:i,1)   , hist(1:i,2)     , '.-m'  );       
          %hist2(1:end,1)  , hist2(1:end,2)    , '.-c' ,... );  
    axis equal;
    
    
    cir=zeros(10,2);
    if( 0 && nxt(2) ~= 0 )        
        R=(nxt(1)^2+nxt(2)^2)/(2*nxt(2));
        thm=asin(nxt(1)/R);
        for j=1:10            
            th=thm*(j-1)/(10-1);
            cir(j,:)=[ sin( th )*R,
                       (1-cos( th ))*R];
        end
    end    
    
    if( 1 && k ~= 0 )                
        thm=asin(nxt(1)*k);
        for j=1:10            
            th=thm*(j-1)/(10-1);
            cir(j,:)=[ sin( th )/k,
                       (1-cos( th ))/k];
        end
    end    
    
    figure(2);
    plot( local_path(:,1) ,local_path(:,2) , '-b.',...
          local_shape(:,1),local_shape(:,2), '+-r',...
          cir(:,1)        ,cir(:,2)        , '.-c' );
    axis equal;
        
    figure(3);
    plot(car.dt*( 0:(i-1)),hist(1:i,4)/car.dltLim*car.StLim,'.-r' );
    figure(4);
    plot(car.dt*( 0:(i-1)),hist(1:i,5)/9.8,'.-r' );
    figure(5);
    plot(car.dt*( 0:(i-1)),hist(1:i,6)/9.8,'.-r' );
    figure(6);
    plot(car.dt*( 0:(i-1)),hist(1:i,7)*3.6,'.-r' );
   
    car=CarRun(car);    
    pause(0.01);
end
