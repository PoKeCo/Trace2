%GetCurveParam
function [Curve]=GetCurve(Start,Stop)
    th0=-Start(3);
    sth0=sin(th0);
    cth0=cos(th0);
    Dlt=(Stop(1:2)-Start(1:2))*[ cth0, sth0;
                                -sth0, cth0];         
    Dlt=[Dlt, Stop(3)-Start(3)];
    
    
    %Curve0=[0,0;Dlt(1),Dlt(2)];    
    Curve0=GetCurveCore(0,Dlt(2),0,Dlt(3),norm(Dlt));
        
    th0=Start(3);
    sth0=sin(th0);
    cth0=cos(th0);
    
    Curve=Curve0*[ cth0, sth0;
                  -sth0, cth0];
    Curve(:,1)=Curve(:,1)+Start(1);
    Curve(:,2)=Curve(:,2)+Start(2);    
    
end
