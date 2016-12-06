%% Butterworth-Tiefpass

% Parameter
NAME = 'Butterworth';
R0 = 3.32E3;
Ra = 3.32E3;
Re = 2.32E3;
Rd = 3.32E3;
R = 10E3;
C = 10E-9;




%% Tschebyscheff-Tiefpass

% Parameter
NAME = 'Tschebyscheff';
R0 = 3.32E3;
Ra = 3.32E3;
Re = 3.09E3;
Rd = 1.69E3;
R = 10E3;
C = 10E-9;

%% Bessel-Tiefpass

% Parameter
NAME = 'Bessel';
R0 = 3.32E3;
Ra = 3.32E3;
Re = 2.43E3;
Rd = 5.36E3;
R = 10E3;
C = 10E-9;

%% TP Grenzfrequenz und Plots

Tau = R*C;
V0 = R0/Ra;
b1 = (R0/Rd)*Tau^2;
a1 = (R0/Re)*Tau;

p = -((2*b1-a1^2)/b1^2);
q = -(1/b1^2);

x1 =  -(p/2)-sqrt(((p/2)^2)-q);
x2 =  -(p/2)+sqrt(((p/2)^2)-q);

wg1 = +sqrt(x1);
wg2 = -sqrt(x1);
wg3 = +sqrt(x2);
wg4 = -sqrt(x2);

fg1 = wg1/(2*pi());
fg2 = wg2/(2*pi());
fg3 = wg3/(2*pi());
fg4 = wg4/(2*pi());


sys1 = tf([V0], [b1 a1 1]);
h = bode(sys1);
h=bodeplot(sys1);
p = getoptions(h);
p.FreqUnits = 'Hz';
p.Grid = 'On';
setoptions(h, p);
title(sprintf('Bode Diagram - %s', NAME))
xlim([10E1 1E4]);

damp_sys1 = 20*log10(bode(sys1, wg3));
