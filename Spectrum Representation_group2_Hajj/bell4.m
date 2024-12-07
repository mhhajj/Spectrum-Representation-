%parameters case 4
fc = 110;        % Carrier frequency (Hz)
fm = 220;        % Modulating frequency (Hz)
I0 = 10;          % Modulation index scale factor
tau = .3;         % Time constant (seconds)
Tdur = 3;        % Duration of sound (seconds)
fs = 11025;      % Sampling frequency (Hz)
%part a
% Generate the bell sound
bell_sound = bell([fc, fm], I0, tau, Tdur, fs);

% Play the sound
soundsc(bell_sound, fs);
%part b

% Calculate the fundamental frequency
f0 = mygcd(fc, fm); 
disp(['Fundamental frequency (f0): ', num2str(f0), ' Hz']);

% You can test this by listening to higher and lower f0's. You will hear
% the difference in the pitch of the sound.

%part c
% Time vector
t = 0:1/fs:Tdur;

% Modulation index envelope
I_t = I0 * exp(-t / tau);

% Instantaneous frequency
fi_t = fc + I_t .* fm;

% Plot the frequency variation
figure;
plot(t, fi_t);
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Frequency Content vs. Time');

% Changing the tau changes how fast the signals decay. Bell 3 and 4 are
% extremes that illustrate this point well. Changing the I0 changes the
% amplitude of the bell sound. The I function controls how loud and long
% the bell sound is and changes throughout the time of it operating.

%part d
% Display the spectrogram for the bell sound
window_size = 512;
overlap = 256;
myspectrogram(bell_sound, fs, window_size, overlap);

%The spectrogram shows how much of each frequency is appearent at each
%moment. Changing I(t) changes that exact thing. 

%part e
% Generate the amplitude envelope
A_t = bellenv(tau, Tdur, fs);

% Plot the signal and envelope
figure;
t = 0:1/fs:Tdur;
plot(t, bell_sound, 'b', t, A_t, 'r--');
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal and Amplitude Envelope');
legend('Signal', 'Envelope');
%part f
% Middle portion of the signal
mid_idx = round(length(bell_sound) / 2);
samples = mid_idx-100:mid_idx+100;

% Plot the zoomed-in signal
figure;
plot(samples, bell_sound(samples));
xlabel('Sample Index');
ylabel('Amplitude');
title('Zoomed-in Signal (Middle Portion)');

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

function myspectrogram(signal, fs, window_size, overlap)
%CUSTOM_SPECTROGRAM Simple custom spectrogram visualization
%
% Inputs:
%   signal      - Input signal
%   fs          - Sampling frequency (Hz)
%   window_size - Size of each segment (samples)
%   overlap     - Number of overlapping samples between segments

    % Number of samples in the signal
    N = length(signal);

    % Step size for each segment
    step = window_size - overlap;

    % Initialize matrix to store FFT results
    num_segments = floor((N - overlap) / step);
    spectrogram_matrix = zeros(window_size / 2, num_segments);

    % Loop through each segment
    for i = 1:num_segments
        % Get the start and end indices of the segment
        start_idx = (i - 1) * step + 1;
        end_idx = start_idx + window_size - 1;

        % Apply windowing (Hamming window)
        if end_idx <= N
            segment = signal(start_idx:end_idx) .* hamming(window_size)';
        else
            segment = signal(start_idx:N);
            segment = [segment, zeros(1, window_size - length(segment))];
            segment = segment .* hamming(window_size)';
        end

        % Compute FFT and store magnitude
        fft_result = abs(fft(segment));
        spectrogram_matrix(:, i) = fft_result(1:window_size / 2);
    end

    % Time and frequency axes
    time_axis = (0:num_segments - 1) * step / fs;
    freq_axis = (0:window_size / 2 - 1) * fs / window_size;

    % Display the spectrogram
    imagesc(time_axis, freq_axis, 20 * log10(spectrogram_matrix + 1e-6)); % dB scale
    axis xy;
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title('Custom Spectrogram');
    colorbar;
end