function O = computeOverlapLength(app, Nfft)
    O = round(app.OverlapPct/100 * Nfft);
end
