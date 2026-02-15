function loadSelectedPair(app)
    % loadSelectedPair Load the selected pair of signals into the app for analysis.
    row = app.RelativePairsTable.Selection;
    if isempty(row), return; end

    T = app.RelativePairsTable.Data;

    name1 = T.Accel1{row};
    name2 = T.Accel2{row};

    axis1 = T.Axis1{row};
    axis2 = T.Axis2{row};

    inv1 = T.Invert1(row);
    inv2 = T.Invert2(row);

    t  = evalin('base', app.TimeVariableField.Value);
    a1 = evalin('base', name1);
    a2 = evalin('base', name2);

    app.loadRelativeSignalsIntoApp(t, a1, a2, axis1, axis2, inv1, inv2);

    app.updateAllTabs();
end
