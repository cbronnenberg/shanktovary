function data = loadWorkspaceData(app)

    data = struct('t',[], 'accelList',{}, 'accelSignals',{});

    vars = evalin('base','whos');
    varNames = {vars.name};

    % Debug print
    fprintf('Variables in base workspace: \n');
    disp(varNames);

    % --- Find time vector ---
    if ~ismember('t', varNames)
        uialert(app.UIFigure, ...
            'Variable ''t'' not found in the BASE workspace. Make sure your data is loaded into base.', ...
            'Missing Time Vector');
        return;
    end

    data.t = evalin('base','t');
    data.t = data.t(:);

    % --- Find accelerometer signals ---
    accelNames = {};
    accelSignals = {};

    for k = 1:numel(vars)
        v = vars(k);

        if strcmp(v.name,'t')
            continue;
        end

        if v.size(1) == numel(data.t) || v.size(2) == numel(data.t)
            accelNames{end+1} = v.name;
            accelSignals{end+1} = evalin('base', v.name);
        end
    end

    if isempty(accelNames)
        uialert(app.UIFigure, ...
            'No accelerometer signals found matching length of t.', ...
            'Missing Signals');
        return;
    end

    data.accelList    = accelNames;
    data.accelSignals = accelSignals;

end
