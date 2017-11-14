function [p,d] = GetLineDist( r, c )
    
    dr = r(2,1:2)-r(1,1:2);
    alpha = dr * ( c-r(1,1:2) )' / (dr*dr');
    if( alpha < 0 )
        p=r(1,1:2);        
    elseif( alpha > 1 )
        p=r(2,1:2);
    else
        p=r(1,1:2)+alpha*(r(2,1:2)-r(1,1:2));
    end
    d=norm( p-c );    
end