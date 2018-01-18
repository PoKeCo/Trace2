function [ shape ] = DrawCar( position, body, blur  )
%
shape=zeros(4,2);
ofs=position(1:2);
th=position(3);th =position(3);
box=[-body(1),+body(2);
     +body(1),+body(2);
     +body(1),-body(2);
     -body(1),-body(2)]/2*blur
rbox=box*[+cos(th), -sin(th); 
          +sin(th), +cos(th)]; 
shape(:,1)=ofs(1)+rbox(:,1);
shape(:,2)=ofs(2)+rbox(:,2);
    
