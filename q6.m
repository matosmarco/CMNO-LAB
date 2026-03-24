% Furuta pendulum - State feedback test
%______________________________________________________________________
clear;
clc;
load('IP_MODEL.mat'); %%Load Matrices A, B, C, D
C = eye(5);
Qr = diag([90,0,3200,0,0]); %Weight Matrix for x
%Bryson rule
Rr = 0.04; %Weight for the input variable
K = lqr(A, B, Qr, Rr); %Calculate feedback gain
%----------------------------------------------------------------------
% Simulate controller
x0=[0.1 0 0 0 0]';
D=[0 0 0 0 0]';
T=5; % Time duration of the simulation
out = sim('q6.slx',T);
figure(1)
gg=plot(out.t.Data,out.x.Data);
set(gg,'LineWidth',1.5)
gg=xlabel('Time (s)');
set(gg,'Fontsize',14);
%gg=ylabel('\beta (rad)');
%title1 = sprintf('State response ($q_{r1}=%g$, $q_{r3}=%g$, $R_r=%g$)', Qr(1,1), Qr(3,3), Rr);
title1 = sprintf('State response ($q_{r1}=%g$, $q_{r2}=%g$, $q_{r3}=%g$, $q_{r4}=%g$,  $R_r=%g$)', Qr(1,1), Qr(2,2), ...
    Qr(3,3), Qr(4,4), Rr);
title(title1, 'Interpreter','latex','FontSize',16)
gg=ylabel('Magnitude of State Variables');
legend('\alpha [rad]', '$\dot{\alpha}$ [rad/s]', '\beta [rad]', ...
    '\dot{\beta} [rad/s]', ...
    '$i$ [A]', 'Interpreter', 'latex', 'Fontsize', 14)

set(gg,'Fontsize',14);
grid on;
grid minor;


figure(2)
gg2=plot(out.t.Data,out.u.Data);
%title2 = sprintf('LQR Control Effort: Motor Voltage [V] ($q_{r1}=%g$, $q_{r3}=%g$, $R_r=%g$)', Qr(1,1), Qr(3,3), Rr');
title2 = sprintf(['LQR Control Effort: Motor Voltage [V] ($q_{r1}=%g$, $q_{r2}=%g$, $q_{r3}=%g$, ' ...
    '$q_{r4}=%g$, $R_r=%g$)'], Qr(1,1), Qr(2,2), Qr(3,3),Qr(4,4), Rr);
title(title2, 'Interpreter','latex','FontSize',16)
set(gg2,'LineWidth',1.5)
gg2=xlabel('Time (s)');
set(gg2,'Fontsize',14);
gg2=ylabel('$u$ [V]', 'Interpreter','latex', 'FontSize', 16);
grid on;
grid minor;
%----------------------------------------------------------------------
% End of file

disp(out.u.Data(1))
disp(eig(A-B*K))