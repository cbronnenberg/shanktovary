function w = computeWindowVector(app, Nfft)
    L = computeWindowLength(app, Nfft);
    switch app.WindowType
        case 'Hann'
            w = hann(L);
        case 'Hamming'
            w = hamming(L);
        case 'Blackman'
            w = blackman(L);
        otherwise
            w = ones(L,1);
    end
end
