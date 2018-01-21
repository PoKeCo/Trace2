%GetNearestOthTest

L=10;
road=GetPathExampleCorner(30,10,75,0);
pos=[1,1,45*pi/180.0];
[s,e,crop_path]=GetAheadOth(road,pos,L);
[p,d,i]=GetNearestOth(road,pos);
figure(1);
clf(1);
hold off;
plot( road(:,1), road(:,2), '.-b',...
      p(1)     ,      p(2), '.-r',...
      pos(1)+[0, cos(pos(3))],      pos(2)+[0,sin(pos(3))], '+g',...%);
      crop_path(:,1), crop_path(:,2), '*-g' );
axis equal;

  