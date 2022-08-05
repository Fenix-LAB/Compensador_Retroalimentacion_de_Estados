%'Compensador: Retroalimentacion de estadpos' 
% Dominio x o z
%Sistema en variables de estado
clc;
A=[0 1 0;0 0 1;-10 -17 -8;]
B=[0;0;1;]
C=[4 1 0] 
D=0 

%Revisamos si el sistema es controlable
Co=ctrb(A,B)
Rango=rank(Co)

%Obtenemos la FT del sistema
[NUM,DEN]=ss2tf(A,B,C,D,1);

%Se obtine la respuesta a un esacalon para evaluar su desempeño
%NN=[0 0 1];
%DD=[1 5 3];
FT=tf(NUM,DEN)
step(FT)
title('Respuesta del sistema') 
hold on

%Se obtienen los polos de un sitema de 2do orden que cumplan con los
%requisitos solicitados (OS y Ts)
OS=20.8;
Ts=4; 
z=(-log(OS/100))/(sqrt(pi^2+log(OS/100)^2)); %Factor de amortiguamiento
wn=4/(z*Ts);                                 %frecuancia natural
[num,den]=ord2(wn,z); 

%Polos dominantes
r=roots(den);                             

%Si es necesario se propone un tercer polo   
polod=-4;
%Creamos un vector con los valores de los polos dominantes
polos=[r(1) r(2) polod]; % polos=[r(1) r(2) polod];

%Obtenermos el vector K (Comparacion de la acuacion caracteristica y la
%ecuacion deseada, pero el comando acker ya hace todo)
K=acker(A,B,polos)

%Obtenemos la MAtriz A compensada, que es la unica que cambia en todo el
%sistema
Acom=A-B*K;

%Vemos la respuesta a un esacalon del sistema compensado
[NUM2,DEN2]=ss2tf(Acom,B,C,0);
FTC=tf(NUM2,DEN2)
step(FTC)


