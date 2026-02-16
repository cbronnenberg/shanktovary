function updatePSDPlot(app)

    if ~isvalid(app) || isempty(app.PSDPanel) || ~isvalid(app.PSDPanel)
        return;
    end

    parent = app.PSDPanel;

    % Clear graphics
    kids = parent.Children;
    for k = 1:numel(kids)
        if isa(kids(k),'matlab.graphics.Graphics') || isa(kids(k),'matlab.graphics.layout.TiledChartLayout')
            delete(kids(k));
        end
    end

    tl = tiledlayout(parent,3,2);
    tl.Padding = 'compact';
    tl.TileSpacing = 'compact';

    t = app.t;
    fs = 1/mean(diff(t));

    sigA = app.curSignals.aF;
    sigV = app.curSignals.v;
    sigD = app.curSignals.d;

    p = app.getFFTParams();
    window   = p.Window;
    overlap  = p.OverlapLength;
    nfft     = p.Nfft;

    % Helper
    function [f,P,cRMS] = computePSD(x)
        [P,f] = pwelch(x, window, overlap, nfft, fs);
        df = f(2)-f(1);
        cRMS = sqrt(cumsum(P)*df);
    end

    % --- Accel PSD ---
    [fA,PA,cA] = computePSD(sigA);
    ax = nexttile(tl);
    plot(ax, fA, PA);
    app.applyPlotStyle(ax, 'Accel PSD', 'Frequency (Hz)', 'PSD', {'Accel'});

    ax = nexttile(tl);
    plot(ax, fA, cA);
    app.applyPlotStyle(ax, 'Accel Cumulative RMS', 'Frequency (Hz)', 'RMS', {'Accel'});

    % --- Velocity PSD ---
    [fV,PV,cV] = computePSD(sigV);
    ax = nexttile(tl);
    plot(ax, fV, PV);
    app.applyPlotStyle(ax, 'Velocity PSD', 'Frequency (Hz)', 'PSD', {'Velocity'});

    ax = nexttile(tl);
    plot(ax, fV, cV);
    app.applyPlotStyle(ax, 'Velocity Cumulative RMS', 'Frequency (Hz)', 'RMS', {'Velocity'});

    % --- Displacement PSD ---
    [fD,PD,cD] = computePSD(sigD);
    ax = nexttile(tl);
    plot(ax, fD, PD);
    app.applyPlotStyle(ax, 'Displacement PSD', 'Frequency (Hz)', 'PSD', {'Displacement'});

    ax = nexttile(tl);
    plot(ax, fD, cD);
    app.applyPlotStyle(ax, 'Displacement Cumulative RMS', 'Frequency (Hz)', 'RMS', {'Displacement'});

end
