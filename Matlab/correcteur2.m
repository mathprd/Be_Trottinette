clear all
close all
clc

%% CONSTANTES
E = 24 ;
Rmoteur = 1 ;
L = 2e-3 ;
t_elec = L/Rmoteur ;
SI = 0.104 ;
R5 = 5.1e3 ;
R8 = 10e3 ;
R12 = 10e3 ;
R18 = 12e3 ;
R21 = 220 ;
C2 = 22e-9 ;
C7 = 22e-9 ;
Kretour = SI * (R8/(R5+R8)*(1+R18/R12)) ;
t1 = (R5*R8*C2)/(R5+R8) ;
f1 = 1/(2*pi*t1) ;
t2 = R21*C7 ;
f2 = 1/(2*pi*t2) ;
tm = t_elec ;
fm = 1/(2*pi*tm) ;
ft = 400 ;
fi = (ft*Rmoteur)/(2*E*Kretour) ;
ti = 1/(2*pi*fi) ;



%% FONCTIONS DE TRANSFERT
numG = [2*E] ;
denG = [Rmoteur*t_elec Rmoteur] ;
G =tf(numG,denG) ;

numF = [Kretour] ;
denF = [t1*t2 t1+t2 1] ;
F = tf(numF,denF) ;

numC = [tm 1] ;
denC = [ti 0] ;
C = tf(numC,denC) ;

%% BODES
figure(1)
bode(C*F*G)

figure(2)
bode(C*G/(1+C*G*F))

%% SIMULATION
simu = sim('FonctionBO.slx') ;

%% TRACÉ DES COURBES
figure(3)
plot(simu.yout{1}.Values)
hold on
plot(simu.yout{2}.Values)
title('Courant')
grid ;
legend('Icons','Is');

figure(4)
plot(simu.yout{4}.Values)
hold on 
title ('rapport cyclique')
grid;
legend('alpha');


