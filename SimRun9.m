%SimRun9


car=CarInitAccord ( 10, -10,  -0*pi/180,   0.0, 32/3.6, 0.0, 0);
road=GetPathExampleCorner(300,12,75,0);
%CrvEst=GetCurveture(road,car4c);

vdst=30/3.6;

for f=1:2
    figure(f);
    clf(f);    
end


hist_cnt=300;
hist=zeros(hist_cnt,16);
car.v=0;

for i=1:hist_cnt
    L=10.0+0.0*car.v;
    [s,e,crop_path]=GetAheadOth(road,[car.x,car.y,car.th],L);
    shape = DrawCar( [car.x, car.y, -car.th], [car.L, car.W], 1.0  );
    k=sin(car.dlt)/car.L;
    hist(i,1:7)=[car.x,car.y,car.th,k,car.v*car.v*k,car.a,car.v];
    local_path=GetLocal(crop_path,car);
    local_shape = DrawCar( [0, 0, 0], [car.L, car.W], 1.0  );
    nxt=local_path(end,:);
    %nxt=local_path(4,:);
    ksum=0;
    kcnt=0;
    k=2*nxt(2)/(nxt(1)^2+nxt(2)^2);
    if( 1 )
        refdlt=asin( k*car.L );
    else
        refdlt=atan2(nxt(2),nxt(1));
    end
    
        
    if( k~=0 )
        refv=min( vdst, sqrt(9.8*0.3/abs(k)) );
    else
        refv=vdst;
    end
    refv*3.6    
    car.a=(refv-car.v)/car.dt * 0.125;
    refdlt=max(-car.dltLim,min(+car.dltLim,( refdlt )));
    
    
    car.ddlt=(refdlt-car.dlt)*1.0/car.dt;
        
    
    ddltLim=90/car.StLim*car.dltLim/car.dt;
    car.ddlt=max(-ddltLim,min(+ddltLim,car.ddlt));
    
    figure(1);
    plot( road(:,1)     , road(:,2)     , '.-b', ...
          crop_path(:,1), crop_path(:,2), '.-g', ...
          shape(:,1)    , shape(:,2)      , '+-r', ...  
          hist(1:i,1)   , hist(1:i,2)     , '.-m',...
          hist2(1:i,1)  , hist2(1:i,2)     , '.-c'  );       
          
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
        
    %figure(3);
    %plot(car.dt*( 0:(i-1)),hist(1:i,4)/car.dltLim*car.StLim,'.-r' );
    %figure(4);
    %plot(car.dt*( 0:(i-1)),hist(1:i,5)/9.8,'.-r' );
    %figure(5);
    %plot(car.dt*( 0:(i-1)),hist(1:i,6)/9.8,'.-r' );
    %figure(6);
    %plot(car.dt*( 0:(i-1)),hist(1:i,7)*3.6,'.-r' );
   
    car=CarRun(car);    
    pause(0.01);
end
