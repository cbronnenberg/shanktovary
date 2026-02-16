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

    nexttile(tl);

    t = app.t;
    fs = 1/mean(diff(t));
    sig = app.curSignals.aF;

    window = hamming(512);
    noverlap = 256;
    nfft = 1024;

    spectrogram(sig, window, noverlap, nfft, fs, 'yaxis');
    title('Spectrogram');
    colorbar;

end
