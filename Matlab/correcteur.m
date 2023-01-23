clear all
close all
clc

%% CONSTANTES
E = 24 ;
Rmoteur = 1 ;
L = 2e-3 ;
tm = L/Rmoteur ;
Gain_Capteur = 0.104 ;
R5 = 5.1e3 ;
R8 = 10e3 ;
R12 = 10e3 ;
R18 = 12e3 ;
R21 = 220 ;
C2 = 22e-9 ;
C7 = 22e-9 ;
Kretour = Gain_Capteur * (R8/(R5+R8)*(1+R18/R12)) ;
t1 = (R5*R8*C2)/(R5+R8) ;
f1 = 1/(2*pi*t1) ;
t2 = R21*C7 ;
f2 = 1/(2*pi*t2) ;
t = tm ;
f = 1/(2*pi*t) ;
ft = 400 ;
fi = (ft*Rmoteur)/(2*E*Kretour) ;
ti = 1/(2*pi*fi) ;
Fe = 9*ft ;
Te = 1/Fe ;

%% FONCTIONS DE TRANSFERT
numCD = [2*E] ;
denCD = [Rmoteur*tm Rmoteur] ;
CD =tf(numCD,denCD) ;

numCR = [Kretour] ;
denCR = [t1*t2 t1+t2 1] ;
CR = tf(numCR,denCR) ;

numC = [t 1] ;
denC = [ti 0] ;
C = tf(numC,denC) ;

%% DISCRETISATION
Cz = c2d(C,Te,'tustin') ;

%% BODES
figure(1)
bode(C*CR*CD)

figure(2)
bode(C*CD/(1+C*CD*CR))

%% SIMULATION
simu = sim('FonctionBFenZ_et_correcteur_isole.slx') ;
%%simu = sim('FonctionBFenZ_et_correcteur_isole.slx') ;
%%simu = sim('FonctionBO.slx') ;

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

figure(5)
plot(simu.yout{3}.Values)
title ('Evolution de l erreur')
grid;
legend('Erreur');

figure(6)
plot(simu.yout{5}.Values)
title('Courant correcteur seul')
grid ;
legend('Is');