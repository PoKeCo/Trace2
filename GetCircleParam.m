function [C,R]=GetCircleParam(P)
%Get Circle Param
    X=1;
    Y=2;
    PP=P.^2;
    Q=P(1:2,:)-P(2:3,:);
    D =4*Q(1,X)*Q(2,Y)-4*Q(2,X)*Q(1,Y);
    Du=+2*Q(2,Y)*(PP(1,X)-PP(2,X)+PP(1,Y)-PP(2,Y)) ...
       -2*Q(1,Y)*(PP(2,X)-PP(3,X)+PP(2,Y)-PP(3,Y));
    Dv=+2*Q(1,X)*(PP(2,X)-PP(3,X)+PP(2,Y)-PP(3,Y)) ...
       -2*Q(2,X)*(PP(1,X)-PP(2,X)+PP(1,Y)-PP(2,Y));
    C=zeros(1,2);
    C(1)=Du/D;
    C(2)=Dv/D;
    R   =sqrt( (P(1,1)-C(1))^2 + (P(1,2)-C(2))^2 );
    
    if(0)
        c_size=101;
        ary_c=zeros(c_size,2);
        for thi=1:c_size
            th=2*pi/(c_size-1)*(thi-1);
            ary_c(thi,:)=C+R*[cos(th),sin(th)];       
        end
        plot( ary_c(:,1), ary_c(:,2), '.-',...
                  P(:,1),     P(:,2), 'o',...
                  C(:,1),     C(:,2), '*'    );
        axis equal;      
    end
end