% Simulate controller
T=20; % Time duration of the simulation
% sim('q8.slx',T);
gg=plot(out.t.Data,out.y.Data);
set(gg,'LineWidth',1.5)
gg=xlabel('Time (s)');
set(gg,'Fontsize',14);
gg=ylabel('\beta (rad)');
set(gg,'Fontsize',14);
