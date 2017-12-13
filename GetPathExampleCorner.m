function [pos,car_init]=PathExampleCorner(cnt,Rsmp,Prd,Tr)
%randn('seed',1);
    
    car_init=CarInitAccord( 0, 0,  0, 0, 30/3.6, 0, 0 );
    car0=car_init;
    pos=zeros(cnt,4);
    alt=-1;
    %Rsmp=20;
    for t=1:cnt
        Gmt=mod(t,Prd)-Prd/2;
        if( Tr==0 )
            if( 0<=Gmt && Gmt<Rsmp )
                car0.dlt = alt*pi/2/Rsmp/car_init.v*car_init.WB/car_init.dt;
            else
                car0.dlt = 0;
            end
        else
            if    ( -Tr<=Gmt && Gmt<Tr )
                car0.ddlt =  alt*pi/2/Rsmp/car_init.v*car_init.WB/car_init.dt^2/(2*Tr);
            elseif( (Rsmp-Tr<=Gmt) && (Gmt<Rsmp+Tr) ) 
                car0.ddlt = -alt*pi/2/Rsmp/car_init.v*car_init.WB/car_init.dt^2/(2*Tr);
                %car0.dlt = 0;
            else
                car0.ddlt=0;
            end
        end
        
        Amt=mod(t,Prd*2);
        if( Amt==0 )
            alt = -alt;
        end


        pos(t,1)=car0.x;
        pos(t,2)=car0.y;
        pos(t,3)=car0.th;
        pos(t,4)=car0.dlt/car0.WB;
        car0=CarRun(car0);
        car0.dlt=max(-pi/6,min(pi/6,car0.dlt));

    end
end

