%% BP

% Parameter
NAME = 'Bandsperre';
R0 = 3.32E3;
Ra = 3.32E3;
Rc = 16.5E3;
R = 10E3;
C = 10E-9;

% HP Grenzfrequenz und Plots

Tau = R*C;
V0 = R0/Ra;
b1 = (Tau^2);
a1 = (R0/Rc)*(Tau);

% p = (((a1^2)-(2*b1)-(2*(a1^2)*(Vmax^2)))/b1^2);
% q = (1/(b1^2));
% 
% x1 =  -(p/2)-sqrt(((p/2)^2)-q);
% x2 =  -(p/2)+sqrt(((p/2)^2)-q);
% 
% wg1 = +sqrt(x1);
% wg2 = -sqrt(x1);
% wg3 = +sqrt(x2);
% wg4 = -sqrt(x2);
% 
% fg1 = wg1/(2*pi());
% fg2 = wg2/(2*pi());
% fg3 = wg3/(2*pi());
% fg4 = wg4/(2*pi());


sys1 = tf([(V0*b1) 0 (V0)], [(b1) (a1) 1]);
h = bode(sys1);
h=bodeplot(sys1);
p = getoptions(h);
p.FreqUnits = 'Hz';
p.Grid = 'On';
setoptions(h, p);
title(sprintf('Bode Diagram - %s', NAME))
xlim([10E1 1E4]);

% damp1_sys1 = 20*log10(bode(sys1, wg1))
% damp2_sys1 = 20*log10(bode(sys1, wg3))
