function addAccelInfoOverlay(app, ax)
%ADDACCELINFOOVERLAY  Draws accelerometer metadata overlay on a plot.
%
%   Merged version:
%       - Shows accel name, axis, invert flag
%       - Shows sensitivity, units, notes
%       - Shows filter settings (HP/LP/detrend/taper)
%       - Shows compare mode (A vs B)
%       - Uses annotation textbox (your original style)
%       - Cleans up old overlays safely

%% ------------------------------------------------------------
%  Guards
%% ------------------------------------------------------------
if isempty(app) || ~isvalid(app)
    return
end
if isempty(ax) || ~isvalid(ax)
    return
end
if isempty(app.AccelNames)
    return
end
if isempty(app.AccelTable.Selection)
    return
end

%% ------------------------------------------------------------
%  Determine selected accel index
%% ------------------------------------------------------------
idx = app.AccelTable.Selection(1);

name   = app.AccelNames{idx};
axisID = app.AccelAxes{idx};

% Invert flag (if present)
invertFlag = false;
try
    invertFlag = logical(app.AccelTable.Data{idx,4});
catch
    invertFlag = false;
end

%% ------------------------------------------------------------
%  Read metadata fields (your original fields)
%% ------------------------------------------------------------
sens  = app.SensitivityField.Value;
units = app.UnitsField.Value;
notes = app.AccelNotesField.Value;

%% ------------------------------------------------------------
%  Filtering summary
%% ------------------------------------------------------------
filterLines = {};

if app.DetrendEnabled
    filterLines{end+1} = 'Detrend: ON';
end
if app.TaperEnabled
    filterLines{end+1} = 'Taper: ON';
end
if app.HighpassEnabled
    filterLines{end+1} = sprintf('HP: %.1f Hz (order %d)', ...
        app.HighpassFreq, app.HighpassOrder);
end
if app.LowpassEnabled
    filterLines{end+1} = sprintf('LP: %.1f Hz (order %d)', ...
        app.LowpassFreq, app.LowpassOrder);
end

if isempty(filterLines)
    filterText = 'Filtering: None';
else
    filterText = strjoin(filterLines, '\n');
end

%% ------------------------------------------------------------
%  Compare mode
%% ------------------------------------------------------------
compareMode = app.CompareFiltersCheckBox.Value && ...
              ~isempty(app.ASignalsProcessed) && ...
              ~isempty(app.BSignalsProcessed);

if compareMode
    compareText = 'Compare: A vs B';
else
    compareText = '';
end

%% ------------------------------------------------------------
%  Build overlay text
%% ------------------------------------------------------------
txt = sprintf([ ...
    '%s\n' ...                       % name
    'Axis: %s\n' ...                 % axis
    'Invert: %s\n' ...               % invert flag
    'Sensitivity: %s\n' ...          % sensitivity
    'Units: %s\n' ...                % units
    '%s\n' ...                       % notes
    '%s\n' ...                       % filtering summary
    '%s' ...                         % compare mode
    ], ...
    name, ...
    axisID, ...
    ternary(invertFlag,'YES','NO'), ...
    num2str(sens), ...
    units, ...
    notes, ...
    filterText, ...
    compareText);

%% ------------------------------------------------------------
%  Remove old overlays
%% ------------------------------------------------------------
delete(findall(ax.Parent, 'Tag','AccelInfoOverlay'));

%% ------------------------------------------------------------
%  Draw overlay (annotation textbox)
%% ------------------------------------------------------------
annotation(ax.Parent, 'textbox', ...
    'String', txt, ...
    'FitBoxToText','on', ...
    'BackgroundColor',[1 1 1 0.7], ...
    'EdgeColor','none', ...
    'Position',[0.02 0.70 0.25 0.25], ...  % upper-left
    'Interpreter','none', ...
    'Tag','AccelInfoOverlay');

end


%% ------------------------------------------------------------
%  Helper: ternary operator
%% ------------------------------------------------------------
function out = ternary(cond, a, b)
    if cond
        out = a;
    else
        out = b;
    end
end
