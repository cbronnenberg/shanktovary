function updateBandPlot(app)

    if ~isvalid(app) || isempty(app.BandPanel) || ~isvalid(app.BandPanel)
        return;
    end

    parent = app.BandPanel;

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

    function updateBandPlot(app)

    if ~isvalid(app) || isempty(app.BandPanel) || ~isvalid(app.BandPanel)
        return;
    end

    parent = app.BandPanel;

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
    hold(ax,'on');

    t = app.t;
    fs = 1/mean(diff(t));
    aF = app.curSignals.aF;

    % Example bands
    bands = [5 10; 10 20; 20 50; 50 200; 200 2000];

    p = app.getFFTParams();

    legendEntries = {};

    for k = 1:size(bands,1)
        f1 = bands(k,1);
        f2 = bands(k,2);

        dB = app.bandLimitedDisp(aF, fs, t, f1, f2, p);

        offset = (k-1)*max(abs(dB))*2;
        plot(ax, t, dB + offset, 'LineWidth',1.1);

        legendEntries{end+1} = sprintf('%d-%d Hz', f1, f2);
    end

    app.applyPlotStyle(ax, 'Band-Limited Displacement', 'Time (s)', 'Disp + Offset', legendEntries);

end
nexttile(tl);
    hold on;

    t = app.t;
    fs = 1/mean(diff(t));
    aF = app.curSignals.aF;

    bands = [5 10; 10 20; 20 50; 50 200; 200 2000];

    for k = 1:size(bands,1)
        f1 = bands(k,1);
        f2 = bands(k,2);

        dB = app.bandLimitedDisp(aF, fs, t, f1, f2);
        offset = (k-1)*max(abs(dB))*2;

        plot(t, dB + offset, 'LineWidth',1.1);
    end

    xlabel('Time (s)');
    ylabel('Offset Disp');
    title('Band-Limited Displacement');
    grid on;

end
