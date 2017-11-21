%TraceTestWithCurveture
[RefPath,car0]=GetPathExample(100);
pel=size(RefPath,1);
RefPath(:,1:2)=RefPath(:,1:2)+0.0*randn(pel,2);

axis equal;

CrvEst=GetCurveture(RefPath,car0);
figure(1);
plot(RefPath(:,1),RefPath(:,2),'g.-',...
     CrvEst (:,1),CrvEst (:,2),'r.-' );
axis equal;

figure(2);

vt=(1:size(RefPath,1))-1;
plot(vt,RefPath(:,4),'g.-',...
     vt,CrvEst (:,4),'r.-' );
%plot(vt,CrvEst (:,4),'r.-' );
