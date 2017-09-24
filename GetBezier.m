%
figure(1);
clf(1);
R=10;
th1=30;
th2=30+180;
%for th2=90:30:270
    %for th1=-90:30:90
        rad1= pi/180 * th1;
        rad2= pi/180 * th2;
        B=[ 0,0;
              R*cos(rad1),R*sin(rad1);
           30+R*cos(rad2),R*sin(rad2);
           30,0];

        t=[0:100]'/100.0;
        T=[t.^3,3*t.^2.*(1-t),3*t.*(1-t).^2,(1-t).^3];

        P=T*B;     
            
        plot( P(:,1), P(:,2), '.-',...
              B(:,1), B(:,2), 'o' );
        hold on;
        axis equal;
        K=zeros(size(t,2),3);
        for ti=2:(size(t,1)-1)            
            CP=P((ti-1):(ti+1),:);
            [tmpP,tmpR]=GetCircleParam(CP);
            K(ti,:)=[P(ti,1:2),1/tmpR];
        end
        
        plot( P(:,1), P(:,2), '.-',...
              K(:,1), K(:,3)*100, '.-',...
              B(:,1), B(:,2), 'o' );
        hold on;
        axis equal;
    %end
%end
