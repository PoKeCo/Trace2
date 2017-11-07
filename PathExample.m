%PathExample
           %( x, y, th, dlt,      v, a, j, L,   W, WB )
car0=CarInit( 0, 0,  0,   0, 30/3.6, 0, 0, 5, 1.9,  4 );

pos=zeros(100,3);
for t=1:100
    
    if( mod(t, 10)== 0 )
        car0.ddlt=0.08*randn();
    end
    
    pos(t,1)=car0.x;
    pos(t,2)=car0.y;
    pos(t,3)=car0.dlt;
    
    car0=CarRun(car0);
    
end


dlt=OfsPath( pos(:,1:2), 20*pos(:,3) );
plot( pos(:,1), pos(:,2) , '.-' ,...
      dlt(:,1), dlt(:,2) , '.-' );
axis equal;