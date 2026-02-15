function runRelativeBatch(app)
    T = app.RelativePairsTable.Data;
    stats = [];

    for i = 1:height(T)
        name1 = T.Accel1{i};
        name2 = T.Accel2{i};

        axis1 = T.Axis1{i};
        axis2 = T.Axis2{i};

        inv1 = T.Invert1(i);
        inv2 = T.Invert2(i);

        t  = evalin('base', app.TimeVariableField.Value);
        a1 = evalin('base', name1);
        a2 = evalin('base', name2);

        app.loadRelativeSignalsIntoApp(t, a1, a2, axis1, axis2, inv1, inv2);

        if app.DoExportPlotsCheckBox.Value
            tag = sprintf('%s_minus_%s', name1, name2);
            app.exportAllPlotsForCurrentSignal(tag);
        end

        stats = [stats; app.collectRelativeStats(name1, name2)];
    end

    app.BatchStatsTable = struct2table(stats);
end
