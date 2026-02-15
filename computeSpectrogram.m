function S = computeSpectrogram(app, x)
    [win, overlap, Nfft] = app.getFFTParams();
    fs = app.fs;

    [s, f, t] = spectrogram(x, win, overlap, Nfft, fs);

    S.s = s;
    S.f = f;
    S.t = t;
end
