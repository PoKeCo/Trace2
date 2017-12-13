function Curveture=GetCurveture(RefPath,car0)
    Curveture=zeros(size(RefPath,1),4);
    Curveture(:,1:3)=RefPath(:,1:3);
    
    
    
    x =RefPath(1,1);
    y =RefPath(1,2);
    th=RefPath(1,3);
    
    
    Curveture(1,1) = x;
    Curveture(1,2) = y;
    Curveture(1,3) = th;
    Curveture(1,4) = 0;
    
    for i = 2:(size(RefPath,1)-1)
        P=RefPath((i-1):(i+1),1:2);
        [k,r,u,v]=GetCurvetureCore(P);
        Curveture(i,4) = k;
    end
    Curveture(:,4)=filter(ones(10,1)/10,[1],Curveture(:,4));
    for i = 2:(size(RefPath,1)-1)
        k = Curveture(i,4);
        th=th+car0.v*k*car0.dt;
        x=x+car0.v*car0.dt*cos(th);
        y=y+car0.v*car0.dt*sin(th);
        Curveture(i,1) = x;
        Curveture(i,2) = y;
        Curveture(i,3) = th;
    end
    i=size(RefPath,1);
    
    th=th+car0.v*k*car0.dt;
    x=x+car0.v*car0.dt*cos(th);
    y=y+car0.v*car0.dt*sin(th);
    
    
    Curveture(i,1) = x;
    Curveture(i,2) = y;
    Curveture(i,3) = th;
    Curveture(i,4) = k;
end
    
    