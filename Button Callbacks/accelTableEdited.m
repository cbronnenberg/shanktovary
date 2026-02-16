function accelTableEdited(app, evt)

    if ~isvalid(app)
        return;
    end

    row = evt.Indices(1);
    col = evt.Indices(2);

    % Column mapping:
    % 1 = Select
    % 2 = Name (read-only)
    % 3 = Axis
    % 4 = Invert

    switch col
        case 1  % Select column
            app.handleAccelSelect(row);

        case 3  % Axis column
            app.handleAccelAxisChange(row);

        case 4  % Invert column
            app.handleAccelInvert(row);
    end

    % Update Accel Info panel
    app.updateAccelInfo();

    % Refresh plots
    app.updateTimeHistories();

end
