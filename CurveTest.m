%curvetest
for i=1:3;
    figure(i);
    clf(i);
end
x=0;
y=0;
%P=zeros(Leng,5);
L=100;

k0=0.00;
ke=0.00;
the=0.00;
Range=10;
for L=1:1
    for j=1:(Range*2+1)
        ye = 0.01*(j-1-Range);%*1.2126;        
        [Curve,Coef,s,k,th]=GetCurveCore(k0,ye,ke,the,L);
        figure(1);
        plot(Curve(:,1),Curve(:,2),'.-c');   
        hold on;
        axis equal;    
        
        figure(2);
        plot(s,k,'.-c');   
        hold on;
        
        
        figure(3);
        plot(s,th,'.-c');   
        hold on;
        
    end
end