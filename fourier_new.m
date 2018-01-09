%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sahebeh Dadboud : 1569395
% Assignment3-exe 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



close all;
clear all;

Fs = 150; %Sampling frequency
t = 0:1/Fs:1; %time base

% signal: sum of different frequencies - y(0) = y(1).
x = sin(2*pi*100*t + pi) + 0.4*sin(2*pi*60*t + 0.2*pi) + 0.2*sin(2*pi*80*t) ...
    + 0.8*sin(2*pi*t + 0.3*pi) + 0.7*sin(2*pi*30*t + 1.5*pi);
figure(1);
plot(t,x);
title("signal: sum of sine waves of various frequencies");
xlabel('Time(s)');
ylabel('Amplitude'); 

% power spectrum
nfft = 1024; %length of FFT
X = fft(x,nfft);
X = X(1:nfft/2); %FFT is symmetric. throw away second half
mx = abs(X).^2;

f = Fs*(0:nfft/2-1)/nfft; % Frequency vector
%fVals=fs*(-NFFT/2:NFFT/2-1)/NFFT;
figure(2);
plot(f,mx); 
title('Power Spectrum of Signal'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');

%calculate new time series by averaging.
N = length(x);
z = zeros(1,length(x));
for i = 1:(N-1)
  z(1,i) = 0.5*(x(1,i) + x(1, i+1));
end
z(1,N) = 0.5*(x(1,N) + x(1,1));

nfft = 1024;
Z = fft(z,nfft);
Z = Z(1:nfft/2); %FFT is symmetric. throw away second half
mz = abs(Z).^2;
f = Fs*(0:nfft/2-1)/nfft; % Frequency vector
%fVals=fs*(-NFFT/2:NFFT/2-1)/NFFT;
figure(3);
plot(f,mz);
title('Power Spectrum for smoothed Signal (through averaging)'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');


%calculate new time series using difference filter.
y = zeros(1,N);
for i = 1:(N-1)
  y(1,i) = 0.5*(x(1,i) - x(1, i+1));
end
y(1,N) = 0.5*(x(1,N) - x(1,1));


nfft = 1024; %length of FFT
Y = fft(y,nfft);
Y = Y(1:nfft/2); %FFT is symmetric. throw away second half
my = abs(Y).^2;

f = Fs*(0:nfft/2-1)/nfft; % Frequency vector
%fVals=fs*(-NFFT/2:NFFT/2-1)/NFFT;
figure(4);
plot (f,my);
title('Power Spectrum of new time series using difference filter'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');

