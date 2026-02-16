function accelTableSelectionChanged(app, evt)
% callback for app.AccelTable.SelectionChangedFcn - triggered when user selects a different row in the accelerometer table
    if ~isvalid(app); return; end

    % Get selected row
    sel = app.AccelTable.Selection;
    if isempty(sel)
        return;
    end

    row = sel(1);  % first selected row

    % Update current signal based on selected accelerometer
    app.setCurrentSignalFromIndex(row);

    % Update accel info panel
    app.updateAccelInfo();

    % Refresh time histories
    app.updateTimeHistories();

end
