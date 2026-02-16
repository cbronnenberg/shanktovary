function data = loadWorkspaceData(app)
% LOADWORKSPACEDATA
% Loads time vector (t or Time) and accelerometer signals (acc_*)
% from the base workspace.

    % --- SAFE STRUCT INITIALIZATION ---
    data = struct( ...
        't', [], ...
        'accelList', {{}}, ...
        'accelSignals', {{}} );

    % Debug: show what the app sees
    vars = evalin('base','whos');
    varNames = {vars.name};

    % --- Time vector detection ---
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

    % --- Accelerometer detection ---
    accelNames = {};
    accelSignals = {};

    for k = 1:numel(vars)
        name = vars(k).name;

        if strcmp(name, timeVar)
            continue;
        end

        if ~startsWith(name, 'acc_')
            continue;
        end

        sig = evalin('base', name);
        sig = sig(:);

        if numel(sig) ~= numel(t)
            continue;
        end

        accelNames{end+1} = name;
        accelSignals{end+1} = sig;
    end

    if isempty(accelNames)
        uialert(app.UIFigure, ...
            'No acc_* signals matching length of t found.', ...
            'Missing Accelerometers');
        return;
    end

    data.accelList    = accelNames;
    data.accelSignals = accelSignals;

end
