clear; close all; clc;
%% 2.1 Beat Notes and Frequency Resolution

% x(t) = B cos(2πf_∆t + φ_∆)cos)2πf_ct + φ_c)

% x(t) = A_1 cos(2πf_1t + φ_1) + A_2 cos(2πf_2t + φ_2)

%% 2.1.1 MATLAB Code for Beat Signals

% b(t) = 10 cos(2π4t + 2πrand)cos)2π1024t + 2πrand)

Amp = 10; %-- B in equation above
fc = 1024; %-- center frequency
phic = 2*pi*rand; %-- phase of 2nd sinusoid (random)
fDelta = 4; %-- modulating frequency
phiDelta = 2*pi*rand; %-- phase of 1st sinusoid (random)
tStart = 0; %-- starting time (secs)
tStop = 5; %-- ending time (secs)
fSamp = 8000; %-- sampling rate (Hz)
%
tt = tStart:(1/fSamp):tStop; %-- vector of times
xx = Amp*cos(2*pi*fc*tt+phic).*cos(2*pi*fDelta*tt+phiDelta);

%% 2.1.2 Beat Notes Spectograms

%% 2.1.2(a)

figure
plot(tt,xx)
title('b(t) = 10 cos(2π4t + 2πrand)cos)2π1024t + 2πrand)')
ylabel('amplitude')
xlabel('time (s)')

%% 2.1.2(b)

% spectrum lines = f_c ± f_∆
spectrum_lines = [fc - fDelta; fc + fDelta]; % = [1020 1028]

%% 2.1.2(c)

L_sect = 256;

figure
plotspec(xx,fSamp,L_sect); colorbar, grid on, zoom on
title('Beat note: L_{sect} = 256')
ylabel('Frequency (Hz)')
xlabel('t')

% There is not enough resolution to see two distinct spectrum lines. Even
% when zoomed in, there is not enough data to observe two spectrum lines.

%% 2.1.2(d)

L_sect (2:5) = [512 1024 2048 4192]; % tested these values for L_sect

figure
plotspec(xx,fSamp,3500); colorbar, grid on, zoom on
title('Beat note: L_{sect} = 3500')
ylabel('Frequency (Hz)')
xlabel('t')

% confirmed that at L_sect = 3500, we can still observe two spectrum lines
% when zoomed in. The spectrum values found in part (b) are correct.

T_sect = 3500 / fSamp; % = 0.4375 s

%% 2.1.3 Inverse Relationship: Section Length vs. Frequency Resolution

%% 2.1.3(a)

% |f_1 - f_2| = C / T_sect

% C = T_sect * |f_1 - f_2|

C = T_sect * abs(spectrum_lines(1) - spectrum_lines(2)); % = 3.5

%% 2.1.3(b)

fDeltaNew = 16;
xxNew = Amp*cos(2*pi*fc*tt+phic).*cos(2*pi*fDeltaNew*tt+phiDelta);

new_spectrum_lines = [fc - fDeltaNew; fc + fDeltaNew];
% T_sect = c / |f_1 - f_2|
predicted_T_sect = C / abs(new_spectrum_lines(1) - new_spectrum_lines(2));
% = 0.1094

% L_sect = T_sect * fs
predicted_L_sect = predicted_T_sect * fSamp; % = 875

figure
plotspec(xxNew,fSamp,L_sect(3)); colorbar, grid on, zoom on
title('Beat note')
ylabel('Frequency (Hz)')
xlabel('t')

% tested L_sect values as before (256, 512, 1024), able to see two lines at
% L_sect(3) = 1024

figure
plotspec(xxNew,fSamp,predicted_L_sect); colorbar, grid on, zoom on
title('Beat note: L_{sect} = 875')
ylabel('Frequency (Hz)')
xlabel('t')

% plotted with predicted_L_sect, able to observe two spectrum lines at the
% new spectrum values of 1008 and 1040 when zoomed in