function reloadWorkspace(app)
% RELOADWORKSPACE
% Loads variables from the base workspace, detects accelerometer signals,
% initializes app state, updates UI tables, and refreshes all plots.

    % Safety
    if ~isvalid(app)
        return;
    end

    % ------------------------------------------------------------
    % 1. Load workspace variables
    % ------------------------------------------------------------
    data = loadWorkspaceData(app);   % <-- external helper you already have
    if isempty(data)
        return;
    end

    % Expected fields from loadWorkspaceData:
    %   data.t
    %   data.accelList
    %   data.accelSignals

    app.t            = data.t(:);
    app.AccelNames   = data.accelList;
    app.AccelSignals = data.accelSignals;

    % ------------------------------------------------------------
    % 2. Reset Pair Lists
    % ------------------------------------------------------------
    app.PairAList = {};
    app.PairBList = {};
    if isprop(app, 'PairTable') && ~isempty(app.PairTable)
        app.PairTable.Data = {};
    end

    % ------------------------------------------------------------
    % 3. Populate Accelerometer Table
    % ------------------------------------------------------------
    populateAccelTable(app, app.AccelNames);   % external helper

    % ------------------------------------------------------------
    % 4. Initialize current signal (default = first accel)
    % ------------------------------------------------------------
    if ~isempty(app.AccelSignals)
        setCurrentSignalFromIndex(app, 1);     % external helper
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
    updateAccelInfo(app);   % external helper

    % ------------------------------------------------------------
    % 7. Refresh all plots
    % ------------------------------------------------------------
    refreshAllPlots(app);   % external helper

end
