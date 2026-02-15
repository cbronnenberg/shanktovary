function updateAllTabs(app)
% unify all tab updates into one call, 
% to avoid redundant code and ensure consistency across 
% tabs when switching processing modes.

    switch app.ProcessingMode
        case "Absolute"
            app.updatePSDTab(app.computeAbsolutePSD());
            app.updateTimeDetailTab(app.computeAbsoluteTimeDetail());
            app.updateBandTab(app.computeAbsoluteBandLimited());
            app.updateFFTTab(app.computeAbsoluteFFT());
            app.updateSpectrogramTab(app.computeSpectrogram(app.curSignals.aF));

        case "Relative"
            app.updatePSDTab(app.computeRelativePSD());
            app.updateTimeDetailTab(app.computeRelativeTimeDetail());
            app.updateBandTab(app.computeRelativeBandLimited());
            app.updateFFTTab(app.computeRelativeFFT());
            app.updateSpectrogramTab(app.computeSpectrogram(app.relSignals.daF));
    end
end
