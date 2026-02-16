function data = loadWorkspaceData(app)
% LOADWORKSPACEDATA
% Loads time vector (t or Time) and accelerometer signals (accel_*).
% Parses accel names and detects axis (X/Y/Z) if present.

    % Safe struct initialization
    data = struct( ...
        't', [], ...
        'accelList', {{}}, ...
        'accelSignals', {{}}, ...
        'accelAxes', {{}} );

    % Pull workspace variables
    vars = evalin('base','whos');
    varNames = {vars.name};

    % ------------------------------------------------------------
    % 1. Detect time vector: 't' or 'Time'
    % ------------------------------------------------------------
    if ismember('t', varNames)
        timeVar = 't';
    elseif ismember('Time', varNames)
        timeVar = 'Time';
    else
        uialert(app.UIFigure, ...
            'No time vector ''t'' or ''Time'' found in BASE workspace.', ...
            'Missing Time Vector');
        return;
    end

    t = evalin('base', timeVar);
    t = t(:);
    data.t = t;

    % ------------------------------------------------------------
    % 2. Detect accelerometer signals: prefix 'accel_'
    % ------------------------------------------------------------
    accelNames = {};
    accelSignals = {};
    accelAxes = {};

    for k = 1:numel(vars)
        name = vars(k).name;

        % Skip time vector
        if strcmp(name, timeVar)
            continue;
        end

        % Must start with accel_
        if ~startsWith(name, 'accel_')
            continue;
        end

        % Load signal
        sig = evalin('base', name);
        sig = sig(:);

        % Must match time length
        if numel(sig) ~= numel(t)
            continue;
        end

        % Extract accel name (everything after accel_)
        accelName = extractAfter(name, "accel_");

        % Detect axis
        axis = detectAxisFromName(accelName);

        % Store
        accelNames{end+1}   = accelName;
        accelSignals{end+1} = sig;
        accelAxes{end+1}    = axis;
    end

    if isempty(accelNames)
        uialert(app.UIFigure, ...
            'No accel_* signals matching length of t found.', ...
            'Missing Accelerometers');
        return;
    end

    data.accelList    = accelNames;
    data.accelSignals = accelSignals;
    data.accelAxes    = accelAxes;

end
