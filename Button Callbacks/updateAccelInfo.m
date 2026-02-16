function updateAccelInfo(app)

    sel = app.AccelTable.Selection;
    if isempty(sel)
        app.AccelNameField.Value = '';
        app.AxisField.Value      = '';
        app.InvertCheckBox.Value = false;
        return;
    end

    row = sel(1);
    data = app.AccelTable.Data;

    app.AccelNameField.Value = data{row,2};   % Name
    app.AxisField.Value      = data{row,3};   % Axis
    app.InvertCheckBox.Value = data{row,4};   % Invert

end
