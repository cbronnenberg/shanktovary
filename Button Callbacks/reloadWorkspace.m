function reloadWorkspace(app)


    if ~isvalid(app); return; end

    % 1. Load data from base workspace
    data = app.loadWorkspaceData();
    if isempty(data)
        return;
    end

        % Store on app for later selection
    app.AccelNames   = data.accelList;
    app.AccelSignals = data.accelSignals;

    % 2. Populate accelerometer table
    app.populateAccelTable(data.accelList);

    % 3. Initialize current signals (curSignals, ASignals, BSignals)
    app.initializeCurrentSignals(data);

    % 4. Update accel info panel
    app.updateAccelInfo();

    % 5. Update time histories
    app.updateTimeHistories();

end

