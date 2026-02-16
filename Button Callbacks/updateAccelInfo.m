function updateAccelInfo(app)

    row = app.AccelTable.Selection;
    if isempty(row)
        return;
    end

    idx = row(1);  % first selected row
    name = app.AccelNames{idx};

    % Example metadata lookup (customize as needed)
    app.SensitivityField.Value = 100;  % placeholder
    app.UnitsField.Value = 'g';
    app.CalibrationField.Value = 'N/A';
    app.AccelNotesField.Value = name;

end
