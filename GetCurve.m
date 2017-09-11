%GetCurveParam
function [Curve,Coef,s,k,th]=GetCurve(Start,Stop,Road)
    th0=-Start(3);
    sth0=sin(th0);
    cth0=cos(th0);
    Dlt=(Stop(1:2)-Start(1:2))*[ cth0, sth0;
                                -sth0, cth0];         
    LocRoad(:,1)=Road(:,1)-Start(1);                        
    LocRoad(:,2)=Road(:,2)-Start(2);                            
    LocRoad=LocRoad*[ cth0, sth0;
                     -sth0, cth0];                 
    Dlt=[Dlt, Stop(3)-Start(3)];
        
    [Curve00,Coef,s,k,th]=GetCurveCore(0,0,0,Dlt(3),norm(Dlt));
    [p,d,id]=GetNearest(LocRoad,Curve00(end,1:2));
    %plot(Curve00(:,1),Curve00(:,2),'.c');
    ye=d%norm( Curve00(end,1:2)-Stop(1:2));    
    %plot( [Curve00(end,1),Stop(1)], [Curve00(end,2),Stop(2)], 'o-c' );
    [Curve0,Coef,s,k,th]=GetCurveCore(0,ye,0,Dlt(3),norm(Dlt));
        
    th0=Start(3);
    sth0=sin(th0);
    cth0=cos(th0);
    
    Curve=Curve0*[ cth0, sth0;
                  -sth0, cth0];
    Curve(:,1)=Curve(:,1)+Start(1);
    Curve(:,2)=Curve(:,2)+Start(2);    
    
end
