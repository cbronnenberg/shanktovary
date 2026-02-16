function updateFFTPlot(app)

    if ~isvalid(app) || isempty(app.FFTPanel) || ~isvalid(app.FFTPanel)
        return;
    end

    parent = app.FFTPanel;

    % Clear graphics
    kids = parent.Children;
    for k = 1:numel(kids)
        if isa(kids(k),'matlab.graphics.Graphics') || isa(kids(k),'matlab.graphics.layout.TiledChartLayout')
            delete(kids(k));
        end
    end

    tl = tiledlayout(parent,1,1);
    tl.Padding = 'compact';
    tl.TileSpacing = 'compact';

    ax = nexttile(tl);

    t = app.t;
    fs = 1/mean(diff(t));
    sig = app.curSignals.aF;

    p = app.getFFTParams();
    N = p.Nfft;

    % FFT
    A = abs(fft(sig, N));
    f = (0:N-1)*(fs/N);

    plot(ax, f, A, 'b', 'LineWidth',1.1);
    legendEntries = {'Accel'};

    % A/B compare
    if app.CompareFiltersCheckBox.Value && ~isempty(app.ASignals) && ~isempty(app.BSignals)
        A_A = abs(fft(app.ASignals.aF, N));
        A_B = abs(fft(app.BSignals.aF, N));
        hold(ax,'on');
        plot(ax, f, A_A, 'r', 'LineWidth',1.1);
        plot(ax, f, A_B, 'g', 'LineWidth',1.1);
        legendEntries = {'Accel','A','B'};
    end

    xlim(ax, [0 fs/2]);

    app.applyPlotStyle(ax, 'FFT Magnitude', 'Frequency (Hz)', '|FFT|', legendEntries);

end
