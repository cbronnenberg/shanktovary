function UpdateButtonPushed(app, event)
    app.computeSignals();
    app.updateSpectrogram();
    app.updateTimeHistories();
    app.updateFFT();
    app.updateBandLimited();
end
