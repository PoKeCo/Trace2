%PID Design
s = tf('s');
%P = exp(-1*s) * 1/(1*s+1);
P = tf(1,[1 1],'InputDelay',1.0);
P.InputName = 'u';

P.OutputName = 'y';
P

step(P), grid on
pidstd_tmp=tf([1],[1 1]);
Cpi = pidtune(P,pidstd(1,1),0.006);
%Cpi = pidtune(P,pidstd_tmp,0.006);
Cpi

Tpi = feedback([P*Cpi,1],1,1,1);  % closed-loop model [ysp;d]->y
Tpi.InputName = {'ysp' 'd'};

step(Tpi), grid on

Kp3 = [0.06;0.08;0.1];      % try three increasing values of Kp
Ti3 = repmat(Cpi.Ti,3,1);   % Ti remains the same
C3 = pidstd(Kp3,Ti3);       % corresponding three PI controllers
T3 = feedback(P*C3,1);
T3.InputName = 'ysp';

step(T3)
title('Loss of stability when increasing Kp')

F = 1/(20*s+1);
F.InputName = 'dy';
F.OutputName = 'dp';

% Process
P = exp(-1*s) * 1/(1*s+1);
P.InputName = 'u';
P.OutputName = 'y0';

% Prediction model
Gp = 1/(1*s+1);
Gp.InputName = 'u';
Gp.OutputName = 'yp';

Dp = exp(-1*s);
Dp.InputName = 'yp'; Dp.OutputName = 'y1';

% Overall plant
S1 = sumblk('ym = yp + dp');
S2 = sumblk('dy = y0 - y1');
Plant = connect(P,Gp,Dp,F,S1,S2,'u','ym');

% Design PI controller with 0.08 rad/s bandwidth and 90 degrees phase margin
Options = pidtuneOptions('PhaseMargin',90);
C = pidtune(Plant,pidstd(1,1),0.08,Options);
C.InputName = 'e';
C.OutputName = 'u';
C

% Assemble closed-loop model from [y_sp,d] to y
Sum1 = sumblk('e = ysp - yp - dp');
Sum2 = sumblk('y = y0 + d');
Sum3 = sumblk('dy = y - y1');
T = connect(P,Gp,Dp,C,F,Sum1,Sum2,Sum3,{'ysp','d'},'y');

step(T,'b',Tpi,'r--')
grid on
legend('Smith Predictor','PI Controller')

bode(T(1,1),'b',Tpi(1,1),'r--',{1e-3,1})
grid on
legend('Smith Predictor','PI Controller')

Plants = stack(1,P,P1,P2);  % array of process models
T1 = connect(Plants,Gp,Dp,C,F,Sum1,Sum2,Sum3,{'ysp','d'},'y'); % Smith
Tpi = feedback([Plants*Cpi,1],1,1,1);   % PI

step(T1,'b',Tpi,'r--')
grid on
legend('Smith Predictor 1','PI Controller')

bode(T1(1,1),'b',Tpi(1,1),'r--')
grid on
legend('Smith Predictor 1','PI Controller')

Sum1o = sumblk('e = ysp - yp');  % open the loop at dp
L = connect(P,Gp,Dp,C,F,Sum1o,Sum2,Sum3,{'ysp','d'},'dp');

bodemag(L(1,1))

H = connect(Plants(:,:,2),Gp,Dp,C,Sum1o,Sum2,Sum3,{'ysp','d'},'dy');
H = H(1,1);  % open-loop transfer ysp -> dy
L = F * H;

margin(L)
title('Stability Margins for the Outer Loop (F)')
grid on;
xlim([1e-2 1]);
