function [k,r,u,v]=GetCurvetureCore(P);
    rmax=1000;
    PP=P.^2;
    D =P(2:3,:)-P(1:2,:);
    Dd=4*(D(2,1)*D(1,2)-D(1,1)*D(2,2) );
    Du=2*(D(1,2)*(PP(3,1)-PP(2,1)+PP(3,2)-PP(2,2))-...
          D(2,2)*(PP(2,1)-PP(1,1)+PP(2,2)-PP(1,2))    );
    Dv=2*(D(2,1)*(PP(2,1)-PP(1,1)+PP(2,2)-PP(1,2))-...
          D(1,1)*(PP(3,1)-PP(2,1)+PP(3,2)-PP(2,2))    );
    rn=sqrt( ((Dd*P(1,1)-Du).^2 + (Dd*P(1,2)-Dv).^2 ) );
    rd=Dd;
    %P;
    r = -rn/(rn/rmax+rd);
    k = -rd/rn;
    if( Du==0 )
        u = 0;    
    else
        u = Du/(Du/rmax+Dd);    
    end
    if( Dv==0 )
        v = 0;
    else
        v = Dv/(Dv/rmax+Dd);    
    end
end