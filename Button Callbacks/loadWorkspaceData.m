function data = loadWorkspaceData(app)

    data = struct();

    % Get all variables from base workspace
    vars = evalin('base', 'whos');

    % Detect time vector
    tVar = vars(strcmp({vars.name}, 't'));
    if isempty(tVar)
        uialert(app.UIFigure, 'No time vector ''t'' found in workspace.', 'Missing Data');
        data = [];
        return;
    end
    data.t = evalin('base', 't');

    % Detect accelerometer signals (example: variables starting with 'acc_')
    accelVars = vars(startsWith({vars.name}, 'acc_'));
    if isempty(accelVars)
        uialert(app.UIFigure, 'No accelerometer signals found (expected acc_*).', 'Missing Data');
        data = [];
        return;
    end

    % Load accelerometer signals
    accelList = {};
    accelSignals = {};
    for k = 1:numel(accelVars)
        name = accelVars(k).name;
        accelList{end+1} = name;
        accelSignals{end+1} = evalin('base', name);
    end

    data.accelList = accelList;
    data.accelSignals = accelSignals;

end
