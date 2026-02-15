function swapSelectedPair(app)
    row = app.RelativePairsTable.Selection;
    if isempty(row), return; end

    T = app.RelativePairsTable.Data;

    [T.Accel1{row}, T.Accel2{row}] = deal(T.Accel2{row}, T.Accel1{row});
    [T.Axis1{row},  T.Axis2{row}]  = deal(T.Axis2{row},  T.Axis1{row});
    [T.Invert1(row),T.Invert2(row)] = deal(T.Invert2(row),T.Invert1(row));

    app.RelativePairsTable.Data = T;
end
