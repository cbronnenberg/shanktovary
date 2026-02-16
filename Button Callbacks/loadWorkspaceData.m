function data = loadWorkspaceData(app)
% LOADWORKSPACEDATA
% Detects time vector and accelerometer signals from the workspace.
% Returns a struct with fields:
%   t            – time vector
%   accelList    – cell array of accel names
%   accelSignals – cell array of accel time histories

    data = struct('t',[], 'accelList',{}, 'accelSignals',{});

    % Pull variables from base workspace
    vars = evalin('base', 'whos');

    % --- Find time vector ---
    tVar = find(strcmp({vars.name}, 't'), 1);
    if isempty(tVar)
        uialert(app.UIFigure, 'No time vector ''t'' found in workspace.', 'Missing Data');
        return;
    end

    data.t = evalin('base', 't');
    data.t = data.t(:);

    % --- Find accelerometer signals ---
    accelNames = {};
    accelSignals = {};

    for k = 1:numel(vars)
        v = vars(k);

        % Skip time vector
        if strcmp(v.name, 't')
            continue;
        end

        % Accept only vectors matching length of t
        if v.size(1) == numel(data.t) || v.size(2) == numel(data.t)
            accelNames{end+1} = v.name;
            accelSignals{end+1} = evalin('base', v.name);
        end
    end

    if isempty(accelNames)
        uialert(app.UIFigure, 'No accelerometer signals found matching length of t.', 'Missing Data');
        return;
    end

    data.accelList    = accelNames;
    data.accelSignals = accelSignals;

end
