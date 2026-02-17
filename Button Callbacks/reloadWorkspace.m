function reloadWorkspace(app)
% RELOADWORKSPACE
% Loads workspace variables, parses accel_* signals, initializes UI tables,
% sets current signal, and refreshes all plots.

    if ~isvalid(app)
        return;
    end

    % ------------------------------------------------------------
    % 1. Load workspace data (t, accel names, signals, axes)
    % ------------------------------------------------------------
    data = loadWorkspaceData(app);   % external helper
    if isempty(data) || isempty(data.t)
        return;
    end

    app.t            = data.t(:);
    app.AccelNames   = data.accelList;
    app.AccelSignals = data.accelSignals;
    app.AccelAxes    = data.accelAxes;

    % ------------------------------------------------------------
    % 2. Reset Pair Lists
    % ------------------------------------------------------------
    app.PairAList = {};
    app.PairBList = {};
    if isprop(app, 'PairTable') && ~isempty(app.PairTable)
        app.PairTable.Data = {};
    end

    % ------------------------------------------------------------
    % 3. Populate Accelerometer Table (4 columns)
    %    Select | Name | Axis | Invert
    % ------------------------------------------------------------
    populateAccelTable(app, app.AccelNames, app.AccelAxes);

    % ------------------------------------------------------------
    % 4. Initialize current signal (default = first accel)
    % ------------------------------------------------------------
    if ~isempty(app.AccelSignals)
        setCurrentSignalFromIndex(app, 1);   % external helper
    end

    % ------------------------------------------------------------
    % 5. Auto‑populate Time Segment fields
    % ------------------------------------------------------------
    if ~isempty(app.t)
        app.StartTimeField.Value = app.t(1);
        app.EndTimeField.Value   = app.t(end);
    end

    % ------------------------------------------------------------
    % 6. Update Accel Info panel
    % ------------------------------------------------------------
    updateAccelInfo(app);

    % ------------------------------------------------------------
    % 7. Refresh all plots
    % ------------------------------------------------------------
    refreshAllPlots(app);

end
