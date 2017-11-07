function op=OfsPath( p, o )

    
    p_size=size(p,1);
    
    op=p;
    
    for i=2:(p_size-1)
        prv=p(i-1,:)-p(i,:);
        nxt=p(i+1,:)-p(i,:);
        pn =p(i+1,:)-p(i-1,:);
        %th =( atan2(nxt(2),nxt(1)) + atan2(prv(2),prv(1)) ) / 2;
        th1 = atan2(prv(2),prv(1))+pi/2 ;
        th2 = atan2(nxt(2),nxt(1))-pi/2 ;
        th =  atan2(pn(2),pn(1))+pi/2 ;
        %th = (th1);
        r  = o(i);
        op(i,1) = op(i,1)+r*cos(th);
        op(i,2) = op(i,2)+r*sin(th);
    end
    
    

