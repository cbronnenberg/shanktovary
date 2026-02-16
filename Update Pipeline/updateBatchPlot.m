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

    nexttile(tl);
    title('Batch Processing Results');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    grid on;

    % Placeholder until batch engine is implemented
    text(0.5,0.5,'Batch plots will appear here','HorizontalAlignment','center');

end
