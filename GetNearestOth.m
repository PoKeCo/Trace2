function [p,d,id]=GetNearestOth(r,c)
    Cnt=size(r,1);
    dst=10;
    id=1;
    p=r(1,1:2);
    d=dst;
    
    p0  =c(1,1:2);
    phi=c(1,3)+pi/2;
    cp=cos(phi);
    sp=sin(phi);
    
    for i=1:(Cnt-1)
        c = r(i  ,1:2);
        n = r(i+1,1:2);
        span=norm(n-c);
        d = atan2( n(2)-c(2), n(1)-c(1) );
        cd = cos(d);
        sd = sin(d);                
        ab = (c-p0)/[cp,sp;-cd,-sd];
        if( 0 <= ab(2) && ab(2) <= span )
            if( abs(ab(1)) < dst)
                dst = abs(ab(1));
                id = i;
                p = c + ab(2) * [cd, sd];
                d = dst;
            end
        end
        %d_ref=norm( r(i,:)-c(1:2) );
        %[p_ref,d_ref]=GetLineDist( r(i:(i+1),:), c );
        %if( d_ref<d )
        %    d=d_ref;
        %    p=p_ref;
        %    id=i;
        %end
    end  
end