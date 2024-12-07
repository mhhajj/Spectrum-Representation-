function yy = bellenv(tau, dur, fsamp)
%BELLENV produces envelope function for bell sounds
%
% usage: yy = bellenv(tau, dur, fsamp);
%
% where:
% tau   = time constant (in seconds)
% dur   = duration of the envelope (in seconds)
% fsamp = sampling frequency (in Hz)
%
% returns:
% yy = decaying exponential envelope
% note: produces exponential decay for positive tau

% Define the time vector
t = 0:1/fsamp:dur;

% Generate the decaying exponential
yy = exp(-t / tau);

end