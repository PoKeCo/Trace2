%curvetest
for i=1:3;
    figure(i);
    clf(i);
end
x=0;
y=0;
P=zeros(Leng,4);
L=100;

k0=0.01;
ke=0.01;
the=0.00;
Range=10;
for L=200:50:200
    for j=1:(Range*2+1)
        ye = 2*(j-1-Range);%*1.2126;        
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