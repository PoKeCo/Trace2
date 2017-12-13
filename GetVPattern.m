function [VPat] = GetVPattern(CrvEst,VMax,XaMax,YaMax);
    dT=0.1;
    t_size = size(CrvEst,1);
    VPat = size(t_size,1);
    
    vmin=VMax;
    %BackTrace
    for t=t_size:(-1):1
        k = abs(CrvEst(t,4));
        vv=YaMax/( YaMax/(VMax*VMax) + k);
        v = sqrt(vv);
        vmin = min( vmin + XaMax*dT, VMax );
        if( v < vmin )
            vmin = v;
        end
        VPat(t,1)=vmin;
    end
    
    for t=1:t_size;
        k = abs(CrvEst(t,4));
        vv=YaMax/( YaMax/(VMax*VMax) + k);
        v = sqrt(vv);
        vmin = min( vmin + XaMax*dT, VMax );
        if( v < vmin )
            vmin = v;
        end
        VPat(t,1)=min(VPat(t,1), vmin );
    end