function [f, mag, phase] = computeFFT(app, x, t)
% COMPUTEFFT
% Unified FFT helper that:
%   - pulls params from getFFTParams()
%   - applies windowing
%   - applies overlap (if needed later)
%   - returns f, magnitude, and phase
%   - uses Nfft consistently across all spectral routines

    % --- Sampling frequency ---
    fs = 1 / mean(diff(t));

    % --- FFT parameters ---
    p = app.getFFTParams();
    Nfft   = p.Nfft;
    window = p.Window;

    % --- Apply window ---
    % Normalize window energy so magnitude is physically meaningful
    w = window(:);
    xw = x(:) .* w;

    % --- Compute FFT ---
    X = fft(xw, Nfft);

    % --- Frequency vector ---
    f = (0:Nfft-1) * (fs / Nfft);

    % --- Magnitude and phase ---
    mag   = abs(X);
    phase = angle(X);

end
