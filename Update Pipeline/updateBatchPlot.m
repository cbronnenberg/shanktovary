function updateBatchPlot(app)

    if ~isvalid(app) || isempty(app.BatchPanel) || ~isvalid(app.BatchPanel)
        return;
    end

    parent = app.BatchPanel;

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

    text(ax, 0.5, 0.5, 'Batch processing results will appear here', ...
        'HorizontalAlignment','center', ...
        'FontSize',12);

    app.applyPlotStyle(ax, 'Batch Processing', '', '', {});

end

function updateBatchPlot2(app)
%UPDATEBATCHPLOT  Refresh the batch/waterfall plot.

%% Startup guards
if isempty(app) || ~isvalid(app)
    return
end
if isempty(app.BatchPanel) || ~isvalid(app.BatchPanel)
    return
end
if isempty(app.BatchSignals)
    return
end

%% Clear only axes/tiledlayouts
delete(findall(app.BatchPanel, 'Type', 'axes'));
delete(findall(app.BatchPanel, 'Type', 'tiledlayout'));

%% Create layout
tl = tiledlayout(app.BatchPanel, 1, 1, ...
    'TileSpacing', 'compact', ...
    'Padding', 'compact');

ax = nexttile(tl);

%% Waterfall plot
hold(ax, 'on');
colors = lines(numel(app.BatchSignals));

for k = 1:numel(app.BatchSignals)
    sig = app.BatchSignals{k};
    plot(ax, sig.f, sig.Amp + k*app.BatchOffset, ...
         'Color', colors(k,:));
end

hold(ax, 'off');

xlabel(ax, 'Frequency (Hz)');
ylabel(ax, 'Amplitude + Offset');
title(ax, 'Batch / Waterfall');
grid(ax, 'on');

end
