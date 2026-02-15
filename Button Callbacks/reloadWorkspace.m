function reloadWorkspace(app)

    % 1. Load data from base workspace
    data = app.loadWorkspaceData();
    if isempty(data)
        return;
    end

    % 2. Populate accelerometer table
    app.populateAccelTable(data.accelList);

    % 3. Initialize current signals (curSignals, ASignals, BSignals)
    app.initializeCurrentSignals(data);

    % 4. Update accel info panel
    app.updateAccelInfo();

    % 5. Update time histories
    app.updateTimeHistories();

end
