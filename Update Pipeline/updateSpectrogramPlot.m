function updateSpectrogramPlot(app)

    if ~isvalid(app) || isempty(app.SpectrogramPanel) || ~isvalid(app.SpectrogramPanel)
        return;
    end

    parent = app.SpectrogramPanel;

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
    window   = p.Window;
    overlap  = p.OverlapLength;
    nfft     = p.Nfft;

    % Spectrogram
    spectrogram(sig, window, overlap, nfft, fs, 'yaxis', 'Parent', ax);

    title(ax, 'Spectrogram');
    ylabel(ax, 'Frequency (Hz)');
    xlabel(ax, 'Time (s)');
    colorbar(ax);

    % Metadata overlay
    app.addAccelInfoOverlay(ax);

end
