function car=CarInit( x, y, th, dlt, v, a, j, L, W, WB )
    car.dt  = 0.1;
    car.x   = x;
    car.y   = y;
    car.s   = 0;
    car.th  = th;
    car.dlt = dlt;
    car.ddlt= 0;
    car.v   =  v;
    car.a   =  a;
    car.j   =  j;
    car.L   =  L;
    car.W   =  W;
    car.WB  =  WB;
end