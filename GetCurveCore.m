%GetCurveCore
function [Curve,Coef,s,k,th]=GetCurveCore(k0,ye,ke,the,L);
    
    Leng=51;
    s=L*[0:(Leng-1)]'/(Leng-1);
    ds=L/(Leng-1);
    iS = [             s,     (s.^2)/2,   (s.^3)/3,   (s.^4)/4];
    S  = [ ones(Leng,1) ,     (s   )  ,   (s.^2)  ,   (s.^3)  ];
    dS = [ zeros(Leng,1), ones(Leng,1), 2*(s   )  , 3*(s.^2)  ];

    x=0;
    y=0;
    Curve=zeros(Leng,4);
    
    yed=ye/L;
    thed=the;
    k0d=L*k0;
    ked=L*ke;
    
    Cdd=yed*120;
    Cad=k0d;
    
    Cbd=0.5*( 12*thed -4*ked -8*k0d +1*Cdd);
    Ccd=0.5*(-12*thed +6*ked +6*k0d -3*Cdd);
    Coef=[Cad/L;Cbd/L^2;Ccd/L^3;Cdd/L^4];
    k  =  S * Coef;
    th = iS * Coef ;
    x=0;y=0;
    for i=1:Leng
        Curve(i,:)=[x,y,th(i),k(i)];%,k(i),th(i)];
        x = x + cos(th(i)) * ds;
        y = y + sin(th(i)) * ds;
    end    

end