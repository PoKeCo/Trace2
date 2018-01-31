
road=GetPathExample(300);
u=zeros(300,8);
v=zeros(300,8);
for r=1:1
    for i=1:300
        if( i==1 )
            p=-road(i+1,1:2);
        else
            p=road(i-1,1:2);
        end
        c=road(i  ,1:2);
        if( i==300 )
            n=c+(c-p);
        else
            n=road(i+1,1:2);
        end
        v1=c-p;
        v2=n-c;
        th1=atan2(v1(2),v1(1));
        th2=atan2(v2(2),v2(1));
        if( th2-th1 > pi )
            th2=th2-2*pi;
        elseif(th2-th1< -pi)
            th2=th2+2*pi;
        end
        if(0 || th1 > th2 )
            th=(th1+th2)/2-pi/2;
        else
            th=(th1+th2)/2+pi/2;
        end
        u(i,3)=th;    
        u(i,4)=th1;    
        u(i,5)=th2;    
        u(i,6)=norm(v1);        
        u(i,7)=norm(v2);     
        u(i,8)=(th1>th2);
    end
    kmin=10000;
    pmin=[0,0];
    for i=1:299   
        l=u(i,6);
        if( u(i,8)==u(i+1,8) )
            th=u(i,3);
            u(i,1:2)=road(i,1:2)+[cos(th),sin(th)];
            
            phi1=u(i  ,5)-u(i  ,3);
            phi2=u(i+1,5)-u(i+1,3);
            l   =u(i,  7);
            k   = l / ( tan(pi/2-phi1)+tan(pi/2-phi2));
            %u(i,1:2)=road(i,1:2)+k*cos(r/60*2*pi)*[cos(th),sin(th)];
            if( abs(k) < kmin )
                kmin = abs(k);
                pmin = road(i,1:2)+kmin*[cos(th),sin(th)];
            end
        else
            u(i,1:2)=road(i,1:2);
        end
    end
    
    for i=1:299   
            th=u(i,3);            
            u(i,1:2)=road(i,1:2)+kmin*cos(0*i/600*2*pi)*[cos(th),sin(th)];
            v(i,1:2)=road(i,1:2)-kmin*cos(0*i/600*2*pi)*[cos(th),sin(th)];
    end
    
    u(300,1:2)=road(300,1:2);
    v(300,1:2)=road(300,1:2);
    
    plot(road(:,1),road(:,2),'.-',...
         u(:,1),   u(:,2), '.-'  ,...
         v(:,1),   v(:,2), '.-'  ,...
         pmin(1),  pmin(2), '*r' );
    axis equal;
    pause(0.01);
end
