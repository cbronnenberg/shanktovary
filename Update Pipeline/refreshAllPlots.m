function refreshAllPlots(app)
    app.updateTimeHistories();
    app.updateFFTPlot();
    app.updatePSDPlot();
    app.updateSpectrogramPlot();
    app.updateBandPlot();
end
