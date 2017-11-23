function [pos,car_init]=PathExampleCorner(cnt,Rsmp,Prd)
%randn('seed',1);
    
    car_init=CarInit( 0, 0,  pi/4,   0, 30/3.6, 0, 0, 5, 1.9,  4 );
    car0=car_init;
    pos=zeros(cnt,4);
    alt=-1;
    %Rsmp=20;
    for t=1:cnt
        Gmt=mod(t,Prd)-Prd/2;
        if( 0<=Gmt && Gmt<Rsmp )
            car0.dlt = alt*pi/2/Rsmp/car_init.v*car_init.WB/car_init.dt;
        else
            car0.dlt = 0;
        end
        Amt=mod(t,Prd*2);
        if( Amt==0 )
            alt = -alt;
        end
        %if( mod(t, 20)== 0 )
        %    if(  mod(t, 200 )==0 )                
                %car0.ddlt= 0.4;
                %car0.dlt = 0;
        %        car0.dlt = pi/2/20*car_init.WB;
        %    elseif(  mod(t, 200 )==10 )
                %car0.ddlt= -0.4;
         %       car0.dlt = pi/2/20*car_init.WB;
          %  elseif(  mod(t, 200 )==100 )                
                %car0.ddlt= -0.4;
                %car0.dlt = 0;
                %car0.dlt = -pi/2/20*car_init.WB;
           % elseif(  mod(t, 200 )==110 )
                %car0.ddlt= 0.4;
            %    car0.dlt = -pi/2/20*car_init.WB;
            %else
             %   car0.ddlt= 0.00*randn();
             %   car0.dlt = 0.00*randn();
            %end
        %end

        pos(t,1)=car0.x;
        pos(t,2)=car0.y;
        pos(t,3)=car0.th;
        pos(t,4)=car0.dlt/car0.WB;
        car0=CarRun(car0);
        car0.dlt=max(-pi/6,min(pi/6,car0.dlt));

    end
end

