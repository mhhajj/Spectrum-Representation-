function xx = bell(ff, Io, tau, dur, fsamp)
%BELL produce a bell sound
%
% usage: xx = bell(ff, Io, tau, dur, fsamp)
%
% where:
% ff = frequency vector [fc, fm], containing carrier and modulating frequencies
% Io = scale factor for modulation index
% tau = decay parameter for A(t) and I(t)
% dur = duration (in sec.) of the output signal
% fsamp = sampling frequency (in Hz)
%
% returns:
% xx = synthesized bell sound signal

% Extract carrier and modulating frequencies
fc = ff(1); % Carrier frequency
fm = ff(2); % Modulating frequency

% Generate the time vector
t = 0:1/fsamp:dur;

% Generate amplitude envelope A(t)
A = bellenv(tau, dur, fsamp);

% Generate modulation index envelope I(t)
I = Io * bellenv(tau, dur, fsamp);

% Generate the bell sound using the FM synthesis formula
xx = A .* cos(2 * pi * fc * t + I .* cos(2 * pi * fm * t));

end
