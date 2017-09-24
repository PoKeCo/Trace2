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
    
    ye=0;
    for i=1:4
        [Curve00,Coef,s,k,th]=GetCurveCore(0.0,ye,0,Dlt(3),norm(Dlt(1:2)));
        [p,d,id]=GetNearest(LocRoad,Curve00(end,1:2));

        the=-Start(3);
        sthe=sin(the);
        cthe=cos(the);    
        Dlte=(p(1:2)-Curve00(end,1:2))*[ cthe, sthe;
                                     -sthe, cthe];       
        %plot(Curve00(:,1),Curve00(:,2),'.c');
        %ye=d;%norm( Curve00(end,1:2)-Stop(1:2));    
        ye=ye+Dlte(2);
        %ye=p(2);
        %ye
        %plot( [Curve00(end,1),Stop(1)], [Curve00(end,2),Stop(2)], 'o-c' );
        [Curve0,Coef,s,k,th]=GetCurveCore(0.0,ye,0.0,Dlt(3),norm(Dlt(1:2)));       
    end
    %figure(5); 
    %plot( Curve0(:,1), Curve0(:,2), 'o-c',...
    %      LocRoad(:,1), LocRoad(:,2),'.-r');
    %axis equal;
    %hold on;
    
    th0=Start(3);
    sth0=sin(th0);
    cth0=cos(th0);
    
    Curve=Curve0*[ cth0, sth0;
                  -sth0, cth0];
    Curve(:,1)=Curve(:,1)+Start(1);
    Curve(:,2)=Curve(:,2)+Start(2);    
    
end
