function op=OfsPath( p, o )

    
    p_size=size(p,1);
    
    op=p;
    
    i=1;
    pn =p(i+1,:)-p(i,:);
    th =  atan2(pn(2),pn(1))+pi/2 ;
    r  = o(i);
    op(i,1) = op(i,1)+r*cos(th);
    op(i,2) = op(i,2)+r*sin(th);
    
    for i=2:(p_size-1)
        pn =p(i+1,:)-p(i-1,:);
        th =  atan2(pn(2),pn(1))+pi/2 ;
        r  = o(i);
        op(i,1) = op(i,1)+r*cos(th);
        op(i,2) = op(i,2)+r*sin(th);
    end
    
    i=size(op,1);
    pn =p(i,:)-p(i-1,:);
    th =  atan2(pn(2),pn(1))+pi/2 ;
    r  = o(i);
    op(i,1) = op(i,1)+r*cos(th);
    op(i,2) = op(i,2)+r*sin(th);

