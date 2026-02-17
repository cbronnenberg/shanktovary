function reloadWorkspace(app)
% RELOADWORKSPACE
% Loads workspace variables, parses accel_* signals, initializes UI tables,
% sets current signal, processes A/B signals, and refreshes all plots.
%
% This merged version is fully aligned with:
%   - processSignal(app, raw, t)
%   - filterAccel(app, aUS)
%   - A/B processing pipeline
%   - new accel table (Select | Name | Axis | Invert)
%   - new filtering + FFT/PSD/TimeHistory architecture

    %% ------------------------------------------------------------
    % 0. Startup Guards
    %% ------------------------------------------------------------
    if isempty(app) || ~isvalid(app)
        return;
    end

    %% ------------------------------------------------------------
    % 1. Load workspace data (t, accel names, signals, axes)
    %% ------------------------------------------------------------
    data = loadWorkspaceData(app);   % external helper
    if isempty(data) || isempty(data.t)
        return;
    end

    app.t            = data.t(:);
    app.AccelNames   = data.accelList;
    app.AccelSignals = data.accelSignals;
    app.AccelAxes    = data.accelAxes;

    %% ------------------------------------------------------------
    % 2. Reset Pair Lists
    %% ------------------------------------------------------------
    app.PairAList = {};
    app.PairBList = {};

    if isprop(app, 'PairTable') && ~isempty(app.PairTable)
        app.PairTable.Data = {};
    end

    %% ------------------------------------------------------------
    % 3. Populate Accelerometer Table (Select | Name | Axis | Invert)
    %% ------------------------------------------------------------
    populateAccelTable(app, app.AccelNames, app.AccelAxes);

    %% ------------------------------------------------------------
    % 4. Initialize current signal (default = first accel)
    %% ------------------------------------------------------------
    if ~isempty(app.AccelSignals)
        setCurrentSignalFromIndex(app, 1);   % calls processSignal internally
    else
        app.curSignals = [];
    end

    %% ------------------------------------------------------------
    % 5. Process A/B signals (if they exist)
    %% ------------------------------------------------------------
    if isprop(app, 'ASignals') && ~isempty(app.ASignals)
        app.ASignalsProcessed = processSignal(app, app.ASignals, app.t);
    else
        app.ASignalsProcessed = [];
    end

    if isprop(app, 'BSignals') && ~isempty(app.BSignals)
        app.BSignalsProcessed = processSignal(app, app.BSignals, app.t);
    else
        app.BSignalsProcessed = [];
    end

    %% ------------------------------------------------------------
    % 6. Auto‑populate Time Segment fields
    %% ------------------------------------------------------------
    if ~isempty(app.t)
        app.StartTimeField.Value = app.t(1);
        app.EndTimeField.Value   = app.t(end);
    end

    %% ------------------------------------------------------------
    % 7. Update Accel Info panel
    %% ------------------------------------------------------------
    updateAccelInfo(app);

    %% ------------------------------------------------------------
    % 8. Refresh all plots
    %% ------------------------------------------------------------
    refreshAllPlots(app);

end
