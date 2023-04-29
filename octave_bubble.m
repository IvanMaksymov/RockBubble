clc;clear all;close all;

pkg load signal

[time,bubble_out,music] = textread("a.out", "%f %f %f", 'delimiter', ' ', "endofline", "\n", 'headerlines', 3);

figure(1);
subplot(2,1,1);
plot(time(2:end-1)/1e-3,bubble_out(2:end-1),'r-','linewidth',1);hold on;
plot(time(2:end-1)/1e-3,music(2:end-1)*max(bubble_out(2:end-1))/max(music(2:end-1)),'k-','linewidth',1);hold on;
xlabel('Time (ms)')

M = music(4:end-1); L = length(M); windowed_r1 = (M - mean(M.*hanning(L))/mean(hanning(L))).*hanning(L);
#y1FFT = fft(windowed_r1); %taking the DFT of r
y1FFT = fft(M);
dt = time(10) - time(9);
f=(0:L/2)/(dt*L); Y1 = y1FFT;

M = bubble_out(4:end-1); L = length(M); windowed_r1 = (M - mean(M.*hanning(L))/mean(hanning(L))).*hanning(L);
#y1FFT = fft(windowed_r1); %taking the DFT of r
y1FFT = fft(M);
dt = time(10) - time(9);
f=(0:L/2)/(dt*L); Y2 = y1FFT;

figure(2);subplot(1,1,1);set(gca,'fontsize',14);hold on;
plot (f/1e3,abs(Y1(1:L/2+1))/max(abs(Y1(1:L/2+1))),'r-');
plot (f/1e3,abs(Y2(1:L/2+1))/max(abs(Y2(1:L/2+1))),'b-');
set(gca,'fontsize',14);
xlim([0 1]); box on;
xlabel('{\itf} (kHz)'); ylabel('FFT amplitude (arb. units)');

audiowrite ('in.wav', music(2:end-1), 1/dt);
audiowrite ('out.wav', bubble_out(2:end-1), 1/dt);


