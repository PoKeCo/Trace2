function [pos,car_init]=PathExample(cnt)
%randn('seed',1);
    
    car_init=CarInit( 0, 0,  0,   0, 30/3.6, 0, 0, 5, 1.9,  4 );
    car0=car_init;
    pos=zeros(cnt,4);
    for t=1:cnt

        if( mod(t, 20)== 0 )
            if(  mod(t, 200 )==0 )                
                car0.ddlt= 0.4;
                car0.dlt = 0;
            elseif(  mod(t, 200 )==10 )
                car0.ddlt= -0.4;
            elseif(  mod(t, 200 )==100 )                
                car0.ddlt= -0.4;
                car0.dlt = 0;
            elseif(  mod(t, 200 )==110 )
                car0.ddlt= 0.4;
            else
                car0.ddlt= 0.08*randn();
                car0.dlt = 0.08*randn();
            end
        end

        pos(t,1)=car0.x;
        pos(t,2)=car0.y;
        pos(t,3)=car0.th;
        pos(t,4)=car0.dlt/car0.WB;
        car0=CarRun(car0);
        car0.dlt=max(-pi/6,min(pi/6,car0.dlt));

    end
end

