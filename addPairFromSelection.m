function addPairFromSelection(app)
    % Connecting the Relative Pairs Table → Relative Engine
    %  is a bit more complex than the other way around, 
    % because the user can select any row in the AccelTable, 
    % and we need to determine whether to put it in 
    % Accel1 or Accel2 of the RelativePairsTable.
    row = app.AccelTable.Selection;
    if isempty(row), return; end

    data = app.AccelTable.Data;

    name   = data.Name{row};
    axis   = data.Axis{row};
    invert = data.Invert(row);

    T = app.RelativePairsTable.Data;

    if isempty(T) || (~isempty(T.Accel1{end}) && ~isempty(T.Accel2{end}))
        T = [T; {'' '' false '' '' false}];
    end

    if isempty(T.Accel1{end})
        T.Accel1{end} = name;
        T.Axis1{end}  = axis;
        T.Invert1(end)= invert;
    else
        T.Accel2{end} = name;
        T.Axis2{end}  = axis;
        T.Invert2(end)= invert;
    end

    app.RelativePairsTable.Data = T;
end
