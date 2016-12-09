%% Aktive Filter

% Dieses Skript wird für alle Arten die Bodeplots ausgeben und in dem
% aktiven Ordner in Matlab als .png Datei abspeichern.

%% Tiefpaesse

clear all;

% Parameter
NAME = char('Butterworth', 'Tschebyscheff', 'Bessel');
R0 = [3.32E3, 3.32E3, 3.32E3];
Ra = [3.32E3, 3.32E3, 3.32E3];
Re = [2.32E3, 3.09E3, 2.43E3];
Rd = [3.32E3, 1.69E3, 5.36E3];
R = [10E3, 10E3, 10E3];
C = [10E-9, 10E-9, 10E-9];


%% TP Grenzfrequenz und Plots

for i=1:1:3
    
    Tau = R(i)*C(i);
    V0 = R0(i)/Ra(i);
    b1 = (R0(i)/Rd(i))*Tau^2;
    a1 = (R0(i)/Re(i))*Tau;

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
    
    figure();
    h = bode(sys1);
    h=bodeplot(sys1);
    p = getoptions(h);
    p.FreqUnits = 'Hz';
    p.Grid = 'On';
    setoptions(h, p);
    title(sprintf('Bode Diagram - TP - %s', NAME(i,:)));
    xlim([10E1 1E4]);
    
    print(strcat(NAME(i,:),'_Bode_TP_Matlab'),'-dpng');

    damp_sys1 = 20*log10(bode(sys1, wg3))

end

%% Hochpaesse

clear all;

% Parameter
NAME = char('Butterworth', 'Tschebyscheff', 'Bessel');
R0 = [3.32E3, 3.32E3, 3.32E3];
Ra = [3.32E3, 3.32E3, 3.32E3];
Re = [2.32E3, 3.09E3, 2.43E3];
Rf = [3.32E3, 1.69E3, 5.36E3];
R = [10E3, 10E3, 10E3];
C = [10E-9, 10E-9, 10E-9];

%% HP Grenzfrequenz und Plots

for i=1:1:3
    
    Tau = R(i)*C(i);
    V0 = R0(i)/Ra(i);
    b1 = (R0(i)/Rf(i))*(1/Tau^2);
    a1 = (R0(i)/Re(i))*(1/Tau);

    p = (a1^2-(2*b1))/(1-(2*V0^2));
    q = (b1^2)/(1-(2*V0^2));

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


    sys1 = tf([V0*(1/b1) 0 0], [(1/b1) (a1/b1) 1]);
    
    figure();
    h = bode(sys1);
    h=bodeplot(sys1);
    p = getoptions(h);
    p.FreqUnits = 'Hz';
    p.Grid = 'On';
    setoptions(h, p);
    title(sprintf('Bode Diagram - HP - %s', NAME(i,:)));
    xlim([10E1 1E4]);
    
    print(strcat(NAME(i,:),'_Bode_HP_Matlab'),'-dpng');

    damp_sys1 = 20*log10(bode(sys1, wg3))

end

%% Bandsperre

clear all;

% Parameter
NAME = 'Bandsperre';
R0 = 3.32E3;
Ra = 3.32E3;
Rc = 16.5E3;
R = 10E3;
C = 10E-9;

%% BS Grenzfrequenz und Plots

Tau = R*C;
V0 = R0/Ra;
b1 = (Tau^2);
a1 = (R0/Rc)*(Tau);

p = ((a1^2)-(2*b1-4*b1*V0^2)) / ((b1^2)-(2*b1^2*V0^2));
q = (1-(2*V0^2)) / ((b1^2)-(2*b1^2*V0^2));

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


sys1 = tf([(V0*b1) 0 (V0)], [(b1) (a1) 1]);
h = bode(sys1);
h=bodeplot(sys1);
p = getoptions(h);
p.FreqUnits = 'Hz';
p.Grid = 'On';
setoptions(h, p);
title(sprintf('Bode Diagram - %s', NAME))
xlim([10E1 1E4]);

damp1_sys1 = 20*log10(bode(sys1, wg1))
damp2_sys1 = 20*log10(bode(sys1, wg3))

print(strcat(NAME,'_Bode_Matlab'),'-dpng');

%% Bandpass

clear all;

% Parameter
NAME = 'Bandpass';
R0 = 3.32E3;
Ra = 3.32E3;
Rc = 16.5E3;
R = 10E3;
C = 10E-9;

%% BP Grenzfrequenz und Plots

Tau = R*C;
Vmax = R0/Ra;
b1 = (Tau^2);
a1 = (R0/Rc)*(Tau);

p = (((a1^2)-(2*b1)-(2*(a1^2)*(Vmax^2)))/b1^2);
q = (1/(b1^2));

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


sys1 = tf([Vmax*a1 0], [(b1) (a1) 1]);
h = bode(sys1);
h=bodeplot(sys1);
p = getoptions(h);
p.FreqUnits = 'Hz';
p.Grid = 'On';
setoptions(h, p);
title(sprintf('Bode Diagram - %s', NAME))
xlim([10E1 1E4]);

damp1_sys1 = 20*log10(bode(sys1, wg1))
damp2_sys1 = 20*log10(bode(sys1, wg3))

print(strcat(NAME,'_Bode_Matlab'),'-dpng');


