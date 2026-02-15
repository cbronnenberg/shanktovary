function updateAccelInfo(app)

    row = app.AccelTable.Selection;
    if isempty(row)
        return;
    end

    name = app.AccelTable.Data{row,2};

    % Example metadata lookup (customize as needed)
    app.SensitivityField.Value = 100;  % placeholder
    app.UnitsField.Value = 'g';
    app.CalibrationField.Value = 'N/A';
    app.AccelNotesField.Value = name;

end
