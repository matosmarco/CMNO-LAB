% Question 4: Plot the Bode diagram of the open-loop system.
clc;

% Load the matrices that constitutes the model (state model)
load('IP_MODEL.mat');

% Build state-space model 
sys = ss(A,B,C,D);

% Convert state-space representation to transfer function
[num, den]= ss2tf(A,B,C,D);

% Transfer function
transfer_function = tf({num(1,:), num(2, :)},den)

% Bode frequency response of dynamic system
w = {1e-1, 1e4}; % frequency range

tf_1 = tf(num(1,:),den);
margin(tf_1)
bode(sys, w)
%pzplot(sys) % Plot pole-zero map of dynamic system


tf_1 = tf(num(1,:), den);
tf_2 = tf(num(2,:), den);

% Calcular margens para a primeira função
[Gm1, Pm1, Wcg1, Wcp1] = margin(tf_1);
fprintf('TF 1 - Margem de Ganho: %.2f dB, Margem de Fase: %.2f°\n', 20*log10(Gm1), Pm1);

% Calcular margens para a segunda função
[Gm2, Pm2, Wcg2, Wcp2] = margin(tf_2);
fprintf('TF 2 - Margem de Ganho: %.2f dB, Margem de Fase: %.2f°\n', 20*log10(Gm2), Pm2);

% Se quiseres ver o gráfico com as margens anotadas:
figure;
margin(tf_1);
figure;
margin(tf_2);