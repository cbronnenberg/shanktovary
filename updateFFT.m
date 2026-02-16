function updateFFTPlot(app)

    parent = app.FFTPanel;
    delete(parent.Children);

    tl = tiledlayout(parent,1,1);
    ax = nexttile(tl);

    [f, mag] = computeFFT(app, app.curSignals.aF, app.t);

    plot(ax, f, mag, 'b', 'LineWidth',1.1);

    applyPlotStyle(app, ax, 'FFT Magnitude', 'Frequency (Hz)', '|FFT|', {'Accel'});

end
