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
    Curve=zeros(Leng,2);

    %d = 121.26*1.0902 * ye/L;
    d = 121.26* ye/L;
    Ca=  k0*L;
    Cd=   d;
    Cb=  -0.5*(-12*the+4*ke*L+8*Ca-1*Cd);
    Cc=  -0.5*(+12*the-6*ke*L-6*Ca+3*Cd);
    Coef=[Ca/L;Cb/L^2;Cc/L^3;Cd/L^4];
    k  =  S * Coef;
    th = iS * Coef ;
    x=0;y=0;
    for i=1:Leng
        Curve(i,:)=[x,y];%,k(i),th(i)];
        x = x + cos(th(i)) * ds;
        y = y + sin(th(i)) * ds;
    end    

end