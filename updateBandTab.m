function updateBandTab(app, BL)

    % Update table
    names = {BL.band}';
    rmsVals = [BL.rms]';
    maxVals = [BL.max]';
    minVals = [BL.min]';
    meanVals = [BL.mean]';

    app.BandStatsTable.Data = table(names, rmsVals, maxVals, minVals, meanVals, ...
        'VariableNames', {'Band','RMS','Max','Min','Mean'});

    % Optional bar chart
    parent = app.BandPlotPanel;
    delete(parent.Children);

    ax = axes(parent);
    bar(ax, rmsVals);
    set(ax,'XTickLabel',names,'XTickLabelRotation',45);
    ylabel(ax,'RMS');
    title(ax,'Band-Limited RMS');
    grid(ax,'on');

    app.axBand = ax;
end
