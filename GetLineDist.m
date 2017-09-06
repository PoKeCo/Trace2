function [p,d] = GetLineDist( r, c )
    
    dr = r(2,:)-r(1,:);
    alpha = dr * ( c-r(1,:) )' / (dr*dr');
    if( alpha < 0 )
        p=r(1,:);        
    elseif( alpha > 1 )
        p=r(2,:);
    else
        p=r(1,:)+alpha*(r(2,:)-r(1,:));
    end
    d=norm( p-c );    
end