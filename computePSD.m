function PSD = computePSD(app, x)
    [win, overlap, Nfft] = app.getFFTParams();
    fs = app.fs;

    [Pxx, f] = pwelch(x, win, overlap, Nfft, fs);

    PSD.f = f;
    PSD.Pxx = Pxx;
end
