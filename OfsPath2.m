
function [path,rmin]=OfsPath2(road,ofs);
    %road=GetPathExample(300);
    leng=size(road,1);
    u=zeros(leng,8);
    %v=zeros(leng,8);
    for i=1:leng
        if( i==1 )
            p=-road(i+1,1:2);
        else
            p=road(i-1,1:2);
        end
        c=road(i  ,1:2);
        if( i==leng )
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
        if(1 || th1 > th2 )
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
    rmin=10000;
    rmax=10000;
    pmin=[0,0];
    for i=1:(leng-1)   
        l=u(i,6);
        if( u(i,8)==u(i+1,8) )
            th=u(i,3);
            u(i,1:2)=road(i,1:2)+[cos(th),sin(th)];            
            phi1=u(i  ,5)-u(i  ,3);
            phi2=u(i+1,5)-u(i+1,3);
            l   =u(i,  7);
            r   = l /  ( ( tan(pi/2-phi1)+tan(pi/2-phi2) ) + 1/rmax );            
            if( abs(r) < rmin )
                rmin = abs(r);
                pmin = road(i,1:2)+rmin*[cos(th),sin(th)];
            end
        else
            u(i,1:2)=road(i,1:2);
        end
    end
    
    for i=1:(leng-1)  
            th=u(i,3);            
            u(i,1:2)=road(i,1:2)+ofs(i)*[cos(th),sin(th)];
            %v(i,1:2)=road(i,1:2)-ofs(i)*[cos(th),sin(th)];
    end
    th=u(leng,3);
    u(leng,1:2)=road(leng,1:2)+ofs(leng)*[cos(th),sin(th)];
    %v(leng,1:2)=road(leng,1:2);
    path = u;
    %plot(road(:,1),road(:,2),'.-',...
    %     u(:,1),   u(:,2), '.-'  ,...
    %     v(:,1),   v(:,2), '.-'  ,...
    %     pmin(1),  pmin(2), '*r' );
    %axis equal;

end
