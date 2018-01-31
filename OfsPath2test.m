
hold off;
figure(1);
clf(1);

leng =300;
%road=GetPathExample(leng);

road=GetPathExampleCorner(leng,12,75,0);

ofs=zeros(leng,1);
[pathc,rmin]=OfsPath2(road,ofs);

hold on;
rmin = 3;
for r=-rmin:rmin
    ofs=-r*(1-cos([0:(leng-1)]/leng *pi))/2;
    [pathg,rmin]=OfsPath2(road,ofs);
    plot( pathg(:,1), pathg(:,2), '.-m');
    axis equal;
end

ofs=+rmin*(1-cos([0:(leng-1)]/leng *pi))/2;
%ofs=+ones(leng,1)*rmin;
[pathr,rmin]=OfsPath2(road,ofs);
ofs=-rmin*(1-cos([0:(leng-1)]/leng *pi))/2;
%ofs=-ones(leng,1)*rmin;
[pathl,rmin]=OfsPath2(road,ofs);


plot( road (:,1), road (:,2), '.-g',  ...      
      pathr(:,1), pathr(:,2), '.-r',  ...
      pathl(:,1), pathl(:,2), '.-b');
axis equal;
hold off;
  

