function [p,d,id]=GetNearest(r,c)
    Cnt=size(r,1);
    
    d=1000000;
    id=1;
    
    for i=1:(Cnt-1)
        %d_ref=norm( r(i,:)-c(1:2) );
        [p_ref,d_ref]=GetLineDist( r(i:(i+1),:), c );
        if( d_ref<d )
            d=d_ref;
            p=p_ref;
            id=i;
        end
    end  
end