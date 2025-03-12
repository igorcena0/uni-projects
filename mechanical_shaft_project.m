clc
close all
clear all
%% dane
N=14;
a=0.12;
b=0.14;
c=0.12;
n=1000;
m=0.008;
z1=14;
z2=45;
beta=0;
alfa=20;
odAdoB=0:0.001:a;
odBdoC=a+0.001:0.001:a+b;
odCdoD=a+b+0.001:0.001:a+b+c;
x=0:0.001:a+b+c;
%% moment skrecajacy
Ms_pomiedzy=9550*N/n;
for o1=1:length(odAdoB)-1
    Ms1(o1)=0
    o1=o1+1
end
for o2=1:length(odBdoC)
    Ms2(o2)=Ms_pomiedzy
    o2=o2+1
end
for o3=1:length(odCdoD)+1
    Ms3(o3)=0
    o3=o3+1
end
Ms=[Ms1 Ms2 Ms3]
figure(1)
stem(x, Ms)
title('Wykres momentu skręcającego Ms')
xlabel('oś z [m]'), ylabel('wartość momentu Ms [Nm]')
grid on

%% srednice
d1=z1*m/cosd(beta);
d2=z2*m/cosd(beta);
%% sily obwodowe
F1x=2*Ms_pomiedzy/d1;
F2y=2*Ms_pomiedzy/d2;

%% sily promieniowe
F1y=F1x*tand(alfa)/cosd(beta);
F2x=F2y*tand(alfa)/cosd(beta);

%% sily osiowe
F1=F1x*tand(beta);
F2=F2y*tand(beta);

%% rekacje w XZ
Vd=(F1x*a-F2x*(a+b))/(a+b+c);
Va=F1x-Vd-F2x;

%% wykresy XZ
My1=Va.*odAdoB;
My2=Va.*odBdoC-F1x.*(odBdoC-a);
My3=Vd.*(a+b+c-odCdoD);
for i1=1:length(odAdoB)
    T1(i1)=Va
    i1=i1+1
end
for i2=1:length(odBdoC)
    T2(i2)=Va-F1x
    i2=i2+1
end
for i3=1:length(odCdoD)
    T3(i3)=-Vd
    i3=i3+1
end
T=[T1 T2 T3];
My=[My1 My2 My3];
figure(2)
stem(x,T)
title('Wykres siły tnącej w plasczyznie XZ')
xlabel('oś z [m]'), ylabel('wartość siły [N]')
grid on
figure(3)
stem(x, My)
title('Wykres momentu My w plasczyznie XZ')
xlabel('oś z [m]'), ylabel('wartość momentu My [Nm]')
grid on
%% reakcje w YZ
Vd1=(F1y*a-F2y*(a+b))/(a+b+c);
Va1=F1y-F2y-Vd1;

%% wykresy w YZ
Mx1=Va1*odAdoB;
Mx2=Va1*odBdoC-F1y*(odBdoC-a);
Mx3=Vd1*(a+b+c-odCdoD);
for i11=1:length(odAdoB)
    T11(i11)=Va1
    i11=i11+1
end
for i21=1:length(odBdoC)
    T21(i21)=Va1-F1y
    i21=i21+1
end
for i31=1:length(odCdoD)
    T31(i31)=-Vd1
    i31=i31+1
end
T1=[T11 T21 T31];
Mx=[Mx1 Mx2 Mx3];
figure(4)
stem(x,T1)
title('Wykres siły tnącej w plaszczyznie YZ')
xlabel('oś z [m]'), ylabel('wartość siły [N]')
grid on
figure(5)
stem(x, Mx)
title('Wykres momentu Mx w plaszczyznie YZ')
xlabel('oś z [m]'), ylabel('wartość momentu Mx [Nm]')
grid on
%% moment gnacy
for i4=1:length(x)
    Mg(i4)=sqrt(My(i4).^2+Mx(i4).^2)
    i4=i4+1
end
figure(6)
stem(x,Mg)
title('Wykres momentu gnącego')
xlabel("Oś z [m]"), ylabel('Wartość momentu Mg [Nm]')
grid on
%% moment zredukowany
for i5=1:length(x)
    Mzr(i5)=sqrt(Mg(i5).^2+3/4.*Ms(i5).^2)
    i5=i5+1
end
figure(7)
stem(x,Mzr)
title('Wykres momentu zredukowanego')
xlabel("Oś z [m]"), ylabel('Wartość momentu Mzr [Nm]')
grid on
%% srednica
kg=175*10^6;
bezp=2;
d=((32*Mzr*bezp)/(pi*kg)).^(1/3)
figure(8)
plot(x,d*1000)
hold on
title('Wykres teoretyczny średnicy wału')
xlabel("Oś z [m]"), ylabel('Wartość średnicy [mm]')
grid on
% srednica z naddatkiem
wieksze_d=d*1.15;
plot(x,wieksze_d*1000)
%ksztaltowanie
for i=1:60
    ksztaltowanie1(i)=30
    i=i+1
end
for i=1:120
    ksztaltowanie2(i)=38
    i=i+1
end
for i=1:15
    ksztaltowanie3(i)=42
    i=i+1
end
for i=1:35
    ksztaltowanie4(i)=38
    i=i+1
end
for i=1:80
    ksztaltowanie5(i)=35
    i=i+1
end
for i=1:71
    ksztaltowanie6(i)=30
    i=i+1
end
ksztaltowanie=[ksztaltowanie1 ksztaltowanie2 ksztaltowanie3 ksztaltowanie4 ksztaltowanie5 ksztaltowanie6]
plot(x,ksztaltowanie)
legend('średnica teoretyczna', 'średnica z naddatkiem 15%', 'wstępny zarys wału ukształtowanego')
hold off, xlim([0 0.38])
%% dobór łożysk
Lh=10000; %zywotnosc lozysk
Ra=sqrt(Va^2+Va1^2);
Rd=sqrt(Vd^2+Vd1^2);
p=3;
Ca=Ra*(Lh*60*n/10^6)^(1/p)
Cd=Rd*(Lh*60*n/10^6)^(1/p)
%% ugiecie
modul_younga=210*10^9;
d_niebezpieczne=0.04;
I=(pi*d_niebezpieczne^4)/64;

CYZ=(1/(a+b+c))*(F1y*(((b+c)^3)/6)-Va1*(((a+b+c)^3)/6)-F2y*(c^3/6))

for k1=1:length(odAdoB)
    w1(k1)=(-1/(modul_younga*I))*(Va1*(odAdoB(k1))^3/6+CYZ*(odAdoB(k1)));
    k1=k1+1;
end
for k2=1:length(odBdoC)
    w2(k2)=(-1/(modul_younga*I))*(Va1*(odBdoC(k2))^3/6-F1y*(odBdoC(k2)-a)^3/6+CYZ*(odBdoC(k2)));
    k2=k2+1;
end
for k3=1:length(odCdoD)
    w3(k3)=(-1/(modul_younga*I))*(Va1*(odCdoD(k3))^3/6-F1y*(odCdoD(k3)-a)^3/6+F2y*(odCdoD(k3)-a-b)^3/6+CYZ*(odCdoD(k3)));
    k3=k3+1;
end
wYZ=[w1 w2 w3]*1000;

CXZ=(1/(a+b+c))*(F1x*(((b+c)^3)/6)-Va*(((a+b+c)^3)/6)-F2x*(c^3/6))

for k1=1:length(odAdoB)
    w11(k1)=(-1/(modul_younga*I))*(Va*(odAdoB(k1))^3/6+CXZ*(odAdoB(k1)));
    k1=k1+1;
end
for k2=1:length(odBdoC)
    w21(k2)=(-1/(modul_younga*I))*(Va*(odBdoC(k2))^3/6-F1x*(odBdoC(k2)-a)^3/6+CXZ*(odBdoC(k2)));
    k2=k2+1;
end
for k3=1:length(odCdoD)
    w31(k3)=(-1/(modul_younga*I))*(Va*(odCdoD(k3))^3/6-F1x*(odCdoD(k3)-a)^3/6+F2x*(odCdoD(k3)-a-b)^3/6+CXZ*(odCdoD(k3)));
    k3=k3+1;
end
wXZ=[w11 w21 w31]*1000;
figure
subplot(2,1,1)
plot(x,wYZ)
title('Ugięcie dla najbardziej niebezpiecznego przekroju wału w płaszczyźnie YZ')
ylabel('Wartość ugięcia [mm]')
xlabel('Oś z [m]')
grid on
subplot(2,1,2)
plot(x,wXZ)
title('Ugięcie dla najbardziej niebezpiecznego przekroju wału w płaszczyźnie XZ')
ylabel('Wartość ugięcia [mm]')
xlabel('Oś z [m]')
grid on
%% wpusty
l0=(4*Ms_pomiedzy)/(0.009*0.048*1*118*10^6)
%% kat skrecenia
modul_kirchoffa=8.1*10^10;
d1=0.04;
d2=0.045;
d3=0.048;
d4=0.052;
I1=(pi*d1^4)/64;
I2=(pi*d2^4)/64;
I3=(pi*d3^4)/64;
I4=(pi*d4^4)/64;
for k=1:60
    I_kat1(k)=I1
    k+1
end
for k=1:120
    I_kat2(k)=I3
    k+1
end
for k=1:15
    I_kat3(k)=I4
    k+1
end
for k=1:35
    I_kat4(k)=I3
    k+1
end
for k=1:80
    I_kat5(k)=I2
    k+1
end
for k=1:71
    I_kat6(k)=I1
    k+1
end
I_kat=[I_kat1 I_kat2 I_kat3 I_kat4 I_kat5 I_kat6]
for k=1:381
    kat_skrecenia(k)=(Ms(k))/(modul_kirchoffa*I_kat(k))
    k=k+1
end
figure
plot(x,kat_skrecenia)
xlabel("Oś z [m]")
ylabel('Wartość kątu skręcenia na jednostkę długości wału')
title('Wartości kątu skręcenia')
%% ugiecie wypadkowe w B i C
wB=sqrt(wXZ(121)^2+wYZ(121)^2);
wC=sqrt(wXZ(261)^2+wYZ(261)^2);
%% ugiecie gdy przylozymy ciezar tarcz tarcze
Fg1=45.196;
Fg2=399.3;
d_niebezpieczne=0.04;
I=(pi*d_niebezpieczne^4)/64;

CYZciezar=(1/(a+b+c))*((F1y+Fg1)*(((b+c)^3)/6)-Va1*(((a+b+c)^3)/6)-(F2y+Fg2)*(c^3/6))

for k1=1:length(odAdoB)
    w1ciezar(k1)=(-1/(modul_younga*I))*(Va1*(odAdoB(k1))^3/6+CYZciezar*(odAdoB(k1)));
    k1=k1+1;
end
for k2=1:length(odBdoC)
    w2ciezar(k2)=(-1/(modul_younga*I))*(Va1*(odBdoC(k2))^3/6-(F1y+Fg1)*(odBdoC(k2)-a)^3/6+CYZciezar*(odBdoC(k2)));
    k2=k2+1;
end
for k3=1:length(odCdoD)
    w3ciezar(k3)=(-1/(modul_younga*I))*(Va1*(odCdoD(k3))^3/6-(F1y+Fg1)*(odCdoD(k3)-a)^3/6+(F2y+Fg2)*(odCdoD(k3)-a-b)^3/6+CYZciezar*(odCdoD(k3)));
    k3=k3+1;
end
wYZciezar=[w1ciezar w2ciezar w3ciezar]*1000;

CXZciezar=(1/(a+b+c))*(F1x*(((b+c)^3)/6)-Va*(((a+b+c)^3)/6)-F2x*(c^3/6))

for k1=1:length(odAdoB)
    w11ciezar(k1)=(-1/(modul_younga*I))*(Va*(odAdoB(k1))^3/6+CXZciezar*(odAdoB(k1)));
    k1=k1+1;
end
for k2=1:length(odBdoC)
    w21ciezar(k2)=(-1/(modul_younga*I))*(Va*(odBdoC(k2))^3/6-F1x*(odBdoC(k2)-a)^3/6+CXZciezar*(odBdoC(k2)));
    k2=k2+1;
end
for k3=1:length(odCdoD)
    w31ciezar(k3)=(-1/(modul_younga*I))*(Va*(odCdoD(k3))^3/6-F1x*(odCdoD(k3)-a)^3/6+F2x*(odCdoD(k3)-a-b)^3/6+CXZciezar*(odCdoD(k3)));
    k3=k3+1;
end
wXZciezar=[w11ciezar w21ciezar w31ciezar]*1000;
figure
subplot(2,1,1)
plot(x,wYZciezar)
title('Ugięcie dla najbardziej niebezpiecznego przekroju wału w płaszczyźnie YZ uwzględniając ciężar wału')
ylabel('Wartość ugięcia [mm]')
xlabel('Oś z [m]')
grid on
subplot(2,1,2)
plot(x,wXZciezar)
title('Ugięcie dla najbardziej niebezpiecznego przekroju wału w płaszczyźnie XZ uwzględniając ciężar wału')
ylabel('Wartość ugięcia [mm]')
xlabel('Oś z [m]')
grid on

wB_zciezarem=sqrt(wXZciezar(121)^2+wYZciezar(121)^2);
wC_zciezarem=sqrt(wXZciezar(261)^2+wYZciezar(261)^2);

%% krzywa Wohlera
