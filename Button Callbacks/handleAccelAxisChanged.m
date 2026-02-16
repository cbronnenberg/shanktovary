function handleAccelAxisChange(app, row)

    axisChoice = app.AccelTable.Data{row,3};

    % Placeholder for future axis transforms
    % For now, simply recompute curSignals if this row is selected
    if app.AccelTable.Data{row,1}
        app.setCurrentSignalFromIndex(row);
    end

end
