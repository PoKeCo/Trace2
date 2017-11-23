%GetPathExampleCorner

road1=GetPathExampleCorner(500,20,75,10);
road2=GetPathExampleCorner(500,20,75, 0);
plot( road1(:,1), road1(:,2), '-r' ,...
      road2(:,1), road2(:,2), '-b' );
axis equal;
%plot( 1:500,road(:,3),'.-',1:500, road(:,4),'.-' );

