function updateFFTTab(app, F)

    parent = app.FFTPanel;
    delete(parent.Children);

    tl = tiledlayout(parent, 3, 1, ...
        'TileSpacing','compact', ...
        'Padding','compact');

    axA = nexttile(tl,1);
    axV = nexttile(tl,2);
    axD = nexttile(tl,3);

    % Acceleration FFT
    semilogx(axA, F.a.f, abs(F.a.X), 'LineWidth',1.1);
    title(axA,'Acceleration FFT Magnitude');
    ylabel(axA,'|X|');
    grid(axA,'on');
    app.annotateMetadata(axA);

    % Velocity FFT
    semilogx(axV, F.v.f, abs(F.v.X), 'LineWidth',1.1);
    title(axV,'Velocity FFT Magnitude');
    ylabel(axV,'|X|');
    grid(axV,'on');
    app.annotateMetadata(axV);

    % Displacement FFT
    semilogx(axD, F.d.f, abs(F.d.X), 'LineWidth',1.1);
    title(axD,'Displacement FFT Magnitude');
    ylabel(axD,'|X|');
    xlabel(axD,'Frequency (Hz)');
    grid(axD,'on');
    app.annotateMetadata(axD);

    % Store axes
    app.axFFT_a = axA;
    app.axFFT_v = axV;
    app.axFFT_d = axD;
end
