function F = computeFFT(app, x)
    Nfft = app.FFTSizeDropDown.Value;
    fs = app.fs;

    X = fft(x, Nfft);
    f = (0:Nfft-1)' * (fs/Nfft);

    F.f = f;
    F.X = X;
end
