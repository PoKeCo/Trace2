%GetCurveCore
function [Curve]=GetCurveCore(k0,ye,ke,the,L);
    
    Leng=51;
    s=L*[0:(Leng-1)]'/(Leng-1);
    ds=L/(Leng-1);
    iS = [             s,     (s.^2)/2,   (s.^3)/3,   (s.^4)/4];
    S  = [ ones(Leng,1) ,     (s   )  ,   (s.^2)  ,   (s.^3)  ];
    dS = [ zeros(Leng,1), ones(Leng,1), 2*(s   )  , 3*(s.^2)  ];

    x=0;
    y=0;
    Curve=zeros(Leng,2);

    d = 1.2126 * ye;
    Ca=  k0;
    Cd=   d;
    Cb=  -0.5*(-12*the+4*ke+8*Ca-1*Cd);
    Cc=  -0.5*(+12*the-6*ke-6*Ca+3*Cd);
    cc=[Ca/L;Cb/L^2;Cc/L^3;Cd/L^4];
    k  =  S * cc;
    th = iS * cc ;
    x=0;y=0;
    for i=1:Leng
        Curve(i,:)=[x,y];%,k(i),th(i)];
        x = x + cos(th(i)) * ds;
        y = y + sin(th(i)) * ds;
    end

end