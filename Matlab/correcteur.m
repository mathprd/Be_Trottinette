E =1.65; %same que Kfiltre
Kfiltre =(1+12/10)*1/(5100+10000); %Pas 100/100 sur
fT=400;
fi=fT*1/(Kfiltre*2*E*0.1);
tauI = 1/(2*pi*fi);

numG = [0 2*E];
denG = [0 1];
G=tf(numG , denG);

numM = [0 1];
denM=[0.002 1];
M=tf(numM, denM);

N=0.10;

numF=[0 Kfiltre];
denF=[220*22e-9 1];
F=tf(numF,denF);

numF2 = 1;
denF2 = [74e-6 1];
F2=tf(numF2,denF2);

numC=[2e-3 1];
denC=[tauI 0];
C= tf(numC,denC);
