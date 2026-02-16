function updateTimePlot(app)
    delete(app.TimePanel.Children);

    tl = tiledlayout(app.TimePanel, 1, 1, 'Padding', 'compact', 'TileSpacing', 'compact');
    ax = nexttile(tl);

    plot(ax, app.TimeVector, app.TimeSignal);
    app.TimeAxes = ax;
end
