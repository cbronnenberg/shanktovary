function updatePSDTab(app, PSD)

    parent = app.PSDPanel;
    delete(parent.Children);

    tl = tiledlayout(parent, 3, 2, ...
        'TileSpacing','compact', ...
        'Padding','compact');

    % Axes
    axA     = nexttile(tl,1);
    axA_cum = nexttile(tl,2);
    axV     = nexttile(tl,3);
    axV_cum = nexttile(tl,4);
    axD     = nexttile(tl,5);
    axD_cum = nexttile(tl,6);

    % === Acceleration PSD ===
    loglog(axA, PSD.a.f, PSD.a.Pxx, 'LineWidth',1.2);
    title(axA,'Acceleration PSD');
    ylabel(axA,'PSD');
    grid(axA,'on');
    app.annotateMetadata(axA);

    % === Velocity PSD ===
    loglog(axV, PSD.v.f, PSD.v.Pxx, 'LineWidth',1.2);
    title(axV,'Velocity PSD');
    ylabel(axV,'PSD');
    grid(axV,'on');
    app.annotateMetadata(axV);

    % === Displacement PSD ===
    loglog(axD, PSD.d.f, PSD.d.Pxx, 'LineWidth',1.2);
    title(axD,'Displacement PSD');
    ylabel(axD,'PSD');
    xlabel(axD,'Frequency (Hz)');
    grid(axD,'on');
    app.annotateMetadata(axD);

    % === Cumulative RMS ===
    cumA = app.computeCumulativeRMS(PSD.a.f, PSD.a.Pxx);
    cumV = app.computeCumulativeRMS(PSD.v.f, PSD.v.Pxx);
    cumD = app.computeCumulativeRMS(PSD.d.f, PSD.d.Pxx);

    plot(axA_cum, PSD.a.f, cumA, 'LineWidth',1.2);
    title(axA_cum,'Cumulative RMS');
    grid(axA_cum,'on');

    plot(axV_cum, PSD.v.f, cumV, 'LineWidth',1.2);
    title(axV_cum,'Cumulative RMS');
    grid(axV_cum,'on');

    plot(axD_cum, PSD.d.f, cumD, 'LineWidth',1.2);
    title(axD_cum,'Cumulative RMS');
    xlabel(axD_cum,'Frequency (Hz)');
    grid(axD_cum,'on');

    % Store axes for export
    app.axPSD_a  = axA;
    app.axCum_a  = axA_cum;
    app.axPSD_v  = axV;
    app.axCum_v  = axV_cum;
    app.axPSD_d  = axD;
    app.axCum_d  = axD_cum;
end
