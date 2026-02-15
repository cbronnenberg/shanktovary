% Inside AccelerometersSectionPanel
app.AccelTable = uitable(app.AccelerometersSectionPanel, ...
    'ColumnName', {'Select','Name','Axis','Invert'}, ...
    'ColumnEditable', [true false true true], ...
    'ColumnFormat', {'logical','char',{'X','Y','Z'},'logical'}, ...
    'Data', {}, ...
    'RowStriping', 'on');


uicontrol(app.TimeSegmentSectionPanel, 'Style','text', ...
    'String','Start Time:', 'HorizontalAlignment','left');

app.StartTimeField = uieditfield(app.TimeSegmentSectionPanel, 'numeric');

uicontrol(app.TimeSegmentSectionPanel, 'Style','text', ...
    'String','End Time:', 'HorizontalAlignment','left');

app.EndTimeField = uieditfield(app.TimeSegmentSectionPanel, 'numeric');

app.ApplySegmentButton = uibutton(app.TimeSegmentSectionPanel, ...
    'Text','Apply Segment');


app.PairTable = uitable(app.RelativePairsSectionPanel, ...
    'ColumnName', {'A','B'}, ...
    'ColumnEditable', [false false], ...
    'Data', {});

app.AddPairButton = uibutton(app.RelativePairsSectionPanel, ...
    'Text','Add Pair');

app.SwapPairButton = uibutton(app.RelativePairsSectionPanel, ...
    'Text','Swap A/B');


app.BandTable = uitable(app.BandSectionPanel, ...
    'ColumnName', {'Start (Hz)','End (Hz)'}, ...
    'ColumnEditable', [true true], ...
    'Data', {});

app.AddBandButton = uibutton(app.BandSectionPanel, ...
    'Text','Add Band');

app.DeleteBandButton = uibutton(app.BandSectionPanel, ...
    'Text','Delete Band');


app.RunBatchButton = uibutton(app.BatchSectionPanel, ...
    'Text','Run Batch');


    % FILE MENU
fileMenu = uimenu(app.UIFigure, 'Text','File');
uimenu(fileMenu, 'Text','Load Workspace', 'MenuSelectedFcn', @(~,~) app.reloadWorkspace());
uimenu(fileMenu, 'Text','Load File...');
uimenu(fileMenu, 'Text','Export Plot...');
uimenu(fileMenu, 'Text','Exit', 'MenuSelectedFcn', @(~,~) close(app.UIFigure));

% PROCESSING MENU
procMenu = uimenu(app.UIFigure, 'Text','Processing');
uimenu(procMenu, 'Text','FFT Settings...');
uimenu(procMenu, 'Text','Window %');
uimenu(procMenu, 'Text','Overlap %');

% PREFERENCES MENU
prefMenu = uimenu(app.UIFigure, 'Text','Preferences');
uimenu(prefMenu, 'Text','Normalization');
uimenu(prefMenu, 'Text','Filter Settings...');

% TOOLS MENU
toolsMenu = uimenu(app.UIFigure, 'Text','Tools');
uimenu(toolsMenu, 'Text','Cursor Mode');
uimenu(toolsMenu, 'Text','Peak Picking');
uimenu(toolsMenu, 'Text','Dominant Band Detection');

% HELP MENU
helpMenu = uimenu(app.UIFigure, 'Text','Help');
uimenu(helpMenu, 'Text','About');


% toolbar
tb = uitoolbar(app.UIFigure);

% Reload icon
reloadIcon = matlab.ui.internal.toolstrip.Icon.RELOAD_24;
uipushtool(tb, 'Tooltip','Reload Workspace', ...
    'ClickedCallback', @(~,~) app.reloadWorkspace(), ...
    'Icon', reloadIcon);

% Add Pair
addIcon = matlab.ui.internal.toolstrip.Icon.ADD_24;
uipushtool(tb, 'Tooltip','Add Pair', ...
    'ClickedCallback', @(~,~) app.addPair(), ...
    'Icon', addIcon);

% Swap A/B
swapIcon = matlab.ui.internal.toolstrip.Icon.SWITCH_24;
uipushtool(tb, 'Tooltip','Swap A/B', ...
    'ClickedCallback', @(~,~) app.swapPair(), ...
    'Icon', swapIcon);

% Export
exportIcon = matlab.ui.internal.toolstrip.Icon.EXPORT_24;
uipushtool(tb, 'Tooltip','Export Plot', ...
    'ClickedCallback', @(~,~) app.exportPlot(), ...
    'Icon', exportIcon);

    % Checkboxese for Time Segment
    % --- TIME SEGMENT CHECKBOXES ---

app.ShowAccelCheckBox = uicheckbox(app.TimeSegmentSectionPanel, ...
    'Text', 'Show Accel', ...
    'Value', true);

app.ShowVelocityCheckBox = uicheckbox(app.TimeSegmentSectionPanel, ...
    'Text', 'Show Velocity', ...
    'Value', true);

app.ShowDisplacementCheckBox = uicheckbox(app.TimeSegmentSectionPanel, ...
    'Text', 'Show Displacement', ...
    'Value', true);

app.TimeSegmentGrid = uigridlayout(app.TimeSegmentSectionPanel, [3 2]);
app.TimeSegmentGrid.RowHeight = {'fit','fit','fit'};
app.TimeSegmentGrid.ColumnWidth = {'1x','1x'};

app.ShowAccelCheckBox.Layout.Row = 1;
app.ShowAccelCheckBox.Layout.Column = 1;

app.ShowVelocityCheckBox.Layout.Row = 2;
app.ShowVelocityCheckBox.Layout.Column = 1;

app.ShowDisplacementCheckBox.Layout.Row = 3;
app.ShowDisplacementCheckBox.Layout.Column = 1;

% Each checkbox should trigger a refresh of the time histories.
app.ShowAccelCheckBox.ValueChangedFcn = @(~,~) app.updateTimeHistories();
app.ShowVelocityCheckBox.ValueChangedFcn = @(~,~) app.updateTimeHistories();
app.ShowDisplacementCheckBox.ValueChangedFcn = @(~,~) app.updateTimeHistories();

% Compare Mode Checkbox
app.CompareFiltersCheckBox = uicheckbox(app.RelativePairsSectionPanel, ...
    'Text', 'Compare A/B Filters', ...
    'Value', false);

app.CompareFiltersCheckBox.Layout.Row = 3;
app.CompareFiltersCheckBox.Layout.Column = 1;
app.CompareFiltersCheckBox.ValueChangedFcn = @(~,~) app.updateTimeHistories();
