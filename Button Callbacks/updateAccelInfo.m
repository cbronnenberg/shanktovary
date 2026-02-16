function updateAccelInfo(app)
% UPDATEACCELINFO
% Updates the Accel Info panel fields based on the selected accelerometer.

    sel = app.AccelTable.Selection;

    if isempty(sel)
        % Clear fields if nothing selected
        app.AccelNameField.Value = '';
        app.AxisField.Value      = '';
        app.InvertCheckBox.Value = false;
        return;
    end

    row = sel(1);

    data = app.AccelTable.Data;

    app.AccelNameField.Value = data{row,1};
    app.AxisField.Value      = data{row,2};
    app.InvertCheckBox.Value = data{row,3};

end
