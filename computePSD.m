function [f, Pxx] = computePSD(app, x, fs)
%COMPUTEPSD  Welch PSD using app FFT settings.

    % FFT length
    if isprop(app,'NfftDropDown') && isvalid(app.NfftDropDown)
        Nfft = str2double(app.NfftDropDown.Value);
    else
        Nfft = app.Nfft;
    end

    % Window length
    winPct = app.WindowPct / 100;
    winLen = max(32, round(winPct * Nfft));

    % Overlap
    ovPct = app.OverlapPct / 100;
    ovLen = round(ovPct * winLen);

    % Window vector
    w = hann(winLen);

    % Welch PSD
    [Pxx, f] = pwelch(x, w, ovLen, Nfft, fs);

end
