function L = computeWindowLength(app, Nfft)
    L = round(app.WindowPct/100 * Nfft);
end
