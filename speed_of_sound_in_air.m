fs=20000;
t=0:1/fs:5-1/fs;

szum=randn(1,length(t));
% plot(t,szum)
% sound(szum, fs)
A=randn;
f=randn;
phase=randn;
sinus=A*sin(2*pi*f*t+phase);
% plot(t,sinus)

f0 = 100; % starting frequency
f1 = 500; % ending frequency
chirp_signal = chirp(t,f0,5,f1,'logarithmic');
%plot(t,chirp_signal)

sinus_sprzezony=conj(sinus);
szum_sprzezony=conj(szum);
chirp_sprzezony=conj(chirp_signal);
%%
figure(1)
corrLength_sinus=length(sinus)+length(sinus_sprzezony)-1;
splot_sinus=fftshift(ifft(fft(sinus,corrLength_sinus).*conj(fft(sinus,corrLength_sinus))));
[r, lags] = xcorr(sinus,'coeff');
subplot(3,1,1)
plot(lags*1/fs, r)
title('autocorrelation for sinus signal')
xlabel("time (s)")

corrLength_szum=length(szum)+length(szum_sprzezony)-1;
splot_szum=fftshift(ifft(fft(szum,corrLength_szum).*conj(fft(szum,corrLength_szum))));
[r1, lags] = xcorr(szum,'coeff');
subplot(3,1,2)
plot(lags*1/fs, r1)
title('autocorrelation for noise signal')
xlabel("time (s)")

corrLength_chirp=length(chirp_signal)+length(chirp_sprzezony)-1;
splot_chirp=fftshift(ifft(fft(chirp_signal,corrLength_chirp).*conj(fft(chirp_signal,corrLength_chirp))));
[r2, lags] = xcorr(chirp_signal,'coeff');
subplot(3,1,3)
plot(lags*1/fs, r2)
title('autocorrelation for chirp signal')
xlabel("time (s)")
figure(2)
subplot(3,1,1)
plot(t,sinus)
xlabel('Time [s]')
title('Sygnał sinusoidalny')
subplot(3,1,2)
plot(t,szum)
xlabel('Time [s]')
ylabel('Amplitude')
title('Sygnał szumu')
subplot(3,1,3)
plot(t,chirp_signal)
xlabel('Time [s]')
title('Sygnał typu chrip')
chirp1=chirp(t,0,5,10);
chirp2=chirp(t,0,5,1000);
[r2, lags] = xcorr(chirp1,'coeff');
[r3, lags] = xcorr(chirp2,'coeff');
figure(3)
subplot(2,1,1)
plot(lags*1/fs, r2)
title('autokorelacja dla chirpa o małym zakresie częstotliwości')
xlabel("time (s)")
subplot(2,1,2)
plot(lags*1/fs, r3)
title('autokorelacja dla chirpa o dużym zakresie częstotliwości')
xlabel("time (s)")


%%

figure(2)
subplot(3,1,1)
plot(lags*1/fs,splot_sinus)
title('Twierdzenie o splocie dla sinusa')
xlabel('time (s)')

subplot(3,1,2)
plot(lags*1/fs,splot_szum)
title('Twierdzenie o splocie dla szumu')
xlabel('time (s)')

subplot(3,1,3)
plot(lags*1/fs,splot_chirp)
title('Twierdzenie o splocie dla chirpa')
xlabel('time (s)')

%%
zera=zeros(1,4000)

szum_zeros = [zera szum];
sinus_zeros = [zera sinus];
chirp_signal_zeros = [zera chirp_signal];

[kor_sinus, lags1]=xcorr(sinus,sinus_zeros);
[kor_szum, lags1]=xcorr(szum,szum_zeros);
[kor_chirp, lags1]=xcorr(chirp_signal,chirp_signal_zeros);

figure(3)
subplot(3,1,1)
plot(lags1*1/fs,kor_sinus)
title('korelacja sinusa z sinusem opoznionym')
xlabel('time(s)')
subplot(3,1,2)
plot(lags1*1/fs,kor_szum)
title('korelacja szumu z szumem opoznionym')
xlabel('time(s)')
subplot(3,1,3)
plot(lags1*1/fs,kor_chirp)
title('korelacja chirpa z chirpem opoznionym')
xlabel('time(s)')

%%
figure(4)
subplot(3,1,1)
plot(lags*1/fs,splot_sinus)
hold on
plot(lags1*1/fs,kor_sinus)
hold off
xlabel('time (s)'), title('porównanie autokorelacji sinusa z korelacją z sygnałem opóznionym'); legend("autokorelacja","korelacja z sygnałem opóźnionym")

subplot(3,1,2)
plot(lags*1/fs,splot_szum)
hold on
plot(lags1*1/fs,kor_szum)
hold off
xlabel('time (s)'), title('porównanie autokorelacji szumu z korelacją z sygnałem opóznionym'); legend("autokorelacja","korelacja z sygnałem opóźnionym")

subplot(3,1,3)
plot(lags*1/fs,splot_chirp)
hold on
plot(lags1*1/fs,kor_chirp)
hold off
xlabel('time (s)'), title('porównanie autokorelacji chirpa z korelacją z sygnałem opóznionym'); legend("autokorelacja","korelacja z sygnałem opóźnionym")
%%
fs =20000;
dt = 1/fs;
bits = 16;  % Rozdzielczość próbkowania (bitów)
kanal = 1; % Liczba kanałów (1 dla mono, 2 dla stereo)
dlugosc_nagrywania = 10;
%% nagrywanie
% sound(szum,fs)
% recorder=audiorecorder(fs, bits, kanal)
% 
% disp('Rozpoczęcie nagrywania...');
% 
% sound(audio_data,Fs);
% 
% recordblocking(recorder, dlugosc_nagrywania);
% 
% disp('Koniec nagrywania.');
% audio_data = getaudiodata(recorder);
% t = (0:length(audio_data)-1)*(1/fs);
%% autokorealcje glosnikow
fs=20000;
jeden_glosnik=load("nagranie_1glosnik.mat")
dwa_glosniki_niesparowane=load("nagranie_2glosniki_niesparowane.mat")
jeden_glosnik=jeden_glosnik.audio_data';
dwa_glosniki_niesparowane=dwa_glosniki_niesparowane.audio_data';
figure(5)
[r, lags1] = xcorr(jeden_glosnik,'coeff');
plot(lags1*1/fs, r)
title('autokorelacja dla sygnału jednego głośnika w odległości 1 m')
xlabel("time (s)")
ylabel('value of the autocorrelation function')
[r1, lags2] = xcorr(dwa_glosniki_niesparowane,'coeff');
figure
plot(lags2*1/fs, r1)
title('autokorelacja dla sygnału dwóch głośników niesparowanych w odległości 1 m')
xlabel("time (s)")
ylabel('value of the autocorrelation function')
%% sparowane
sparowane1=load("nagranie_2glosniki_sparowanev1.mat")
sparowane1=sparowane1.audio_data;
sparowane2=load("nagranie_2glosniki_sparowanev2.mat")
sparowane2=sparowane2.audio_data;
sparowane3=load("nagranie_2glosniki_sparowanev3.mat")
sparowane3=sparowane3.audio_data;
odsuwane1=load("nagranie_2glosniki_odsuwaniev1.mat")
odsuwane1=odsuwane1.audio_data';
[odsuwane2,fs1]=audioread("Piaskowa.m4a");
odsuwane2=odsuwane2';
[odsuwane3,fs2]=audioread("Józefa Chełmońskiego 2.m4a");
odsuwane3=odsuwane3';
t=0:1/fs:25-1/fs;
% oduswane1_1=oduswane1(100000:199999);
% oduswane1_2=oduswane1(250000:349999);
% oduswane1=[oduswane1_1 oduswane1_2];
odsuwane1_1_1=odsuwane1(100000:139999);
odsuwane1_1_2=odsuwane1(300000:339999);
odsuwane2_1=odsuwane2(240000:335999);
odsuwane2_2=odsuwane2(768000:863999);
% odsuwane2=[odsuwane2_1 odsuwane2_2];
odsuwane3_1=odsuwane3(480000:527999);
odsuwane3_2=odsuwane3(1248000:1296000);
% odsuwane3=[odsuwane3_1 odsuwane3_2]
%%
% t=0:1/fs2:length(odsuwane3)*1/fs2-1/fs2;
% plot(t,odsuwane3)
plot(odsuwane3)
%%
figure(6)
[r, lags3] = xcorr(sparowane1,'coeff');
subplot(3,1,1)
plot(lags3*1/fs, r)
title('autokorelacja sygnału dwóch sparowanych głośników w odległości 1 m')
xlabel("time (s)")
[r1, lags4] = xcorr(sparowane2,'coeff');
subplot(3,1,2)
plot(lags4*1/fs, r1)
xlabel("time (s)")
ylabel('value of the autocorrelation function')
[r1, lags5] = xcorr(sparowane3,'coeff');
subplot(3,1,3)
plot(lags5*1/fs, r1)
xlabel("time (s)")
%% odsuwane
figure(7)
subplot(3,1,1)
[r1, lags6] = xcorr(odsuwane1,'coeff');
plot(lags6*1/fs, r1)
xlabel("time (s)")
title("Autokorelacja dla sygnału sparowanych głośników z odsuwaniem")
subplot(3,1,2)
[r1, lags6] = xcorr(odsuwane2,'coeff');
plot(lags6*1/fs1, r1)
xlabel("time (s)")
ylabel('value of the autocorrelation function')
subplot(3,1,3)
[r1, lags6] = xcorr(odsuwane3,'coeff');
plot(lags6*1/fs2, r1)
xlabel("time (s)")

figure(8)
subplot(3,1,1)
[r1, lags7] = xcorr(odsuwane1_1_1,'coeff');
plot(lags7*1/fs, r1)
xlabel("time (s)")
hold on
[r1, lags8] = xcorr(odsuwane1_1_2,'coeff');
plot(lags8*1/fs, r1)
xlabel("time (s)")
hold off
legend('glośniki koło siebie','glośniki oddalone')
title('Porównanie autokorelacji wyciętych fragmentów sygnału kiedy głośniki są koło siebie i gdy są oddalone')
subplot(3,1,2)
[r1, lags7] = xcorr(odsuwane2_1,'coeff');
plot(lags7*1/fs1, r1)
xlabel("time (s)")
hold on
[r1, lags8] = xcorr(odsuwane2_2,'coeff');
plot(lags8*1/fs1, r1)
xlabel("time (s)")
ylabel('value of the autocorrelation function')
hold off
legend('glośniki koło siebie','glośniki oddalone')
subplot(3,1,3)
[r1, lags7] = xcorr(odsuwane3_1,'coeff');
plot(lags7*1/fs2, r1)
xlabel("time (s)")
hold on
[r1, lags8] = xcorr(odsuwane3_2,'coeff');
plot(lags8*1/fs2, r1)
xlabel("time (s)")
hold off
legend('glośniki koło siebie','glośniki oddalone')
%%
fs=20000;
szum_dluzszy=[szum szum szum szum szum];
% sound(szum_dluzszy,fs)