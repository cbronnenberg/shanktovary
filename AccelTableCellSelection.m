function AccelTableCellSelection(app, event)
    if isempty(event.Indices)
        return
    end

    row = event.Indices(1);
    data = app.AccelTable.Data;

    name   = data.Name{row};
    axis   = data.Axis{row};
    invert = data.Invert(row);

    t = evalin('base', app.TimeVariableField.Value);
    a = evalin('base', name);

    app.loadSignalIntoApp(t, a, axis, invert);

    % Update plots
    app.updateAllTabs();

    % Update RMS quick-look
    app.updateAccelStatsPanel(name, a, invert);
end
