function ret=CarView(x,y,th)
    Lh=4.5/2;
    Wh=1.9/2;
    S=[+Lh, +Wh;
       -Lh, +Wh;
       -Lh, -Wh;
       +Lh, -Wh;
       +Lh, +Wh]
    R=[+cos(th), +sin(th);
       -sin(th), +cos(th)]
    P=[x,y]
    L=S*R+[P;P;P;P;P];
    plot(0,0,'+',L(:,1),L(:,2),'.-');
    axis equal;
    
ret = 0;