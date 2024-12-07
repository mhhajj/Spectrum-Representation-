%4.4 Comments on bell
%parameters to change and test
%fc = 220; 
%fm = 440; 
%I0 = 10; 
%tau = 2; 
%Tdur = 6; 
%fs = 11025;
%part a
% Generate the bell sound
%bell_sound = bell([fc, fm], I0, tau, Tdur, fs);

% Play the sound
%soundsc(bell_sound, fs);

% -Comments on changing f0-
% Changing the fc and fm values to be higher or lower while maintaing 
% the ratio of 1:2 will produce the same bell sound at a higher or lower
% pitch depending if you decrease or increase f0. Because the current
% numbers for fc and fm are large, the sound made with the current test
% conditions is at a high pitch. 

% Parameters 
fc = 200; 
fm = 280; 
I0 = 10; 
tau = 2; 
Tdur = 6; 
fs = 11025;

% Generate the bell sound
bell_sound = bell([fc, fm], I0, tau, Tdur, fs);

% Play the sound
soundsc(bell_sound, fs);

f0 = mygcd(fc, fm); % For Case 1, gcd(110, 220) = 110 Hz
disp(['Fundamental frequency (f0): ', num2str(f0), ' Hz']);

function g = mygcd(a, b)
%MY_GCD Compute the greatest common divisor of two numbers manually
%
% Inputs:
%   a, b - Two positive integers
% Output:
%   g    - Greatest common divisor

    while b ~= 0
        temp = b;
        b = mod(a, b);
        a = temp;
    end
    g = a;
end

% Comments on differenct fc to fm ratios. 
% The current code is setup to have a f0 of 40Hz and ratio of 5:7.
% Increasing the ratio from 5:7 to 5:14 made the sound more robotic and
% higher. When changing the ratio to 14:5 it was similar
% to the 5:14 sound in that it was more robotic, but it was lower in pitch.
% My personal favorite ratio at f0 of 40Hz is 5:9. It sounds like a bell
% from the future to me. 