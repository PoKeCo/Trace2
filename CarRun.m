function n = CarRun(c)
    
    %n.dlt = c.dlt;
    
    n.ddlt = c.ddlt;
    n.dlt  = c.dlt + c.ddlt * c.dt;    
    
    n.j    =  c.j ;
    n.a    =  c.a + n.j * c.dt;
    n.v    =  c.v + n.a * c.dt;
    n.s    =  c.s + n.v * c.dt;
    
    n.th   =  c.th + n.v * n.dlt * c.dt / c.WB;
    
    if(n.th>pi)
        n.th=n.th-2*pi;
    elseif(n.th<-pi)
        n.th=n.th+2*pi;
    end
    
    n.x    = c.x + n.v * cos(n.th) * c.dt;
    n.y    = c.y + n.v * sin(n.th) * c.dt;
    
    %n.ddlt = c.ddlt;
    %n.dlt  = c.dlt + c.ddlt * c.dt;    
    
    
    n.dt   = c.dt;
    n.L    =  c.L;
    n.W    =  c.W;
    n.WB   =  c.WB;
end