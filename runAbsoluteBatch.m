function runAbsoluteBatch(app)
    data = app.AccelTable.Data;
    useIdx = find(data.Use);

    stats = [];

    for i = 1:numel(useIdx)
        row = useIdx(i);

        name   = data.Name{row};
        axis   = data.Axis{row};
        invert = data.Invert(row);

        t = evalin('base', app.TimeVariableField.Value);
        a = evalin('base', name);

        app.loadSignalIntoApp(t, a, axis, invert);

        if app.DoExportPlotsCheckBox.Value
            app.exportAllPlotsForCurrentSignal(name);
        end

        stats = [stats; app.collectAbsoluteStats(name)];
    end

    app.BatchStatsTable = struct2table(stats);
end
