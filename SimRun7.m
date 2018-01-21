%car=CarInitAccord(x, y, th, dlt, v, a, j);
car=CarInitAccord(0, 0, 45*pi/180, 32*pi/180, 30/3.6, 0, 0);

dT=0.1;
for f=1:2
    figure(f);
    clf(f);
end
colidx=1;

for v=-4/4:0.125/2:4/4
    for u=16:4:16        
        car=CarInitAccord(0, 0, 0, 0.00*car.dltLim, 60/3.6, 0, 0);        
        Te=16+24;
        Ta=4*6;
        trj=zeros(Te,4);
        amp=v/4;
        gmax=0;
        for t=1:Te
            k=sin(car.dlt)/car.WB;
            ay=car.v * car.v * k / 9.8;  
            gmax=max(ay,gmax);
            sa=car.dlt / car.dltLim * 450;  
            trj(t,:)=[car.x, car.y, ay, sa];
            if(     t <= u )
                car.ddlt=0;car.ddlt=0;
            elseif( t <= u+Ta/4 )
                car.ddlt=+amp*car.dltLim/(Ta/4*dT);
            elseif( t<=u+3*Ta/4 )
                car.ddlt=-amp*car.dltLim/(Ta/4*dT);
            elseif( t<=u+Ta )
                car.ddlt=+amp*car.dltLim/(Ta/4*dT);
            else
                car.ddlt=0;car.ddlt=0;
            end    
            car=CarRun(car);    
        end
        figure(1);        
        hold on;        
        if( gmax>0.2 )
            plot( trj(:,1), trj(:,2), ['.-k'] );
        else
            plot( trj(:,1), trj(:,2), ['.-',col(colidx)] );
        end
        axis equal;
        figure(2);
        hold on;
        plot( trj(:,3), '.-r' );
        hold on;
    end
    
    col='rgbmcyb';
    colidx=1+mod(colidx,7);
end