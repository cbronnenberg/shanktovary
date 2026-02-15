%% ACCELEROMETERS SECTION
accelGrid = uigridlayout(app.AccelContentPanel, [2 1]);
accelGrid.RowHeight = {'1x','fit'};
accelGrid.ColumnWidth = {'1x'};
accelGrid.Padding = [0 0 0 0];
accelGrid.RowSpacing = 4;

% Table
app.AccelTable = uitable(accelGrid, ...
    'ColumnName', {'Select','Name','Axis','Invert'}, ...
    'ColumnEditable', [true false true true], ...
    'ColumnFormat', {'logical','char',{'X','Y','Z'},'logical'}, ...
    'Data', {}, ...
    'RowStriping', 'on');
app.AccelTable.Layout.Row = 1;

% Buttons row
accelBtnGrid = uigridlayout(accelGrid, [1 3]);
accelBtnGrid.ColumnWidth = {'1x','1x','1x'};
accelBtnGrid.Padding = [0 0 0 0];
accelBtnGrid.Layout.Row = 2;

app.ReloadButton = uibutton(accelBtnGrid, 'Text','Reload');
app.SelectAllButton = uibutton(accelBtnGrid, 'Text','Select All');
app.ClearAllButton = uibutton(accelBtnGrid, 'Text','Clear All');

%% TIME SEGMENTS SECTION
timeGrid = uigridlayout(app.TimeContentPanel, [4 2]);
timeGrid.RowHeight = {'fit','fit','fit','fit'};
timeGrid.ColumnWidth = {'fit','1x'};
timeGrid.Padding = [0 0 0 0];
timeGrid.RowSpacing = 4;

% Start time
uilabel(timeGrid, 'Text','Start Time:', 'HorizontalAlignment','left');
app.StartTimeField = uieditfield(timeGrid, 'numeric');

% End time
uilabel(timeGrid, 'Text','End Time:', 'HorizontalAlignment','left');
app.EndTimeField = uieditfield(timeGrid, 'numeric');

% Checkboxes (Accel / Vel / Disp)
app.ShowAccelCheckBox = uicheckbox(timeGrid, 'Text','Show Accel', 'Value',true);
app.ShowAccelCheckBox.Layout.Column = [1 2];

app.ShowVelocityCheckBox = uicheckbox(timeGrid, 'Text','Show Velocity', 'Value',true);
app.ShowVelocityCheckBox.Layout.Column = [1 2];

app.ShowDisplacementCheckBox = uicheckbox(timeGrid, 'Text','Show Displacement', 'Value',true);
app.ShowDisplacementCheckBox.Layout.Column = [1 2];

% Apply button
app.ApplySegmentButton = uibutton(timeGrid, 'Text','Apply Segment');
app.ApplySegmentButton.Layout.Row = 4;
app.ApplySegmentButton.Layout.Column = [1 2];


%% RELATIVE PAIRS SECTION
pairsGrid = uigridlayout(app.RelativePairsContentPanel, [3 1]);
pairsGrid.RowHeight = {'1x','fit','fit'};
pairsGrid.ColumnWidth = {'1x'};
pairsGrid.Padding = [0 0 0 0];
pairsGrid.RowSpacing = 4;

% Table
app.PairTable = uitable(pairsGrid, ...
    'ColumnName', {'A','B'}, ...
    'ColumnEditable', [false false], ...
    'Data', {});
app.PairTable.Layout.Row = 1;

% Buttons row
pairBtnGrid = uigridlayout(pairsGrid, [1 2]);
pairBtnGrid.ColumnWidth = {'1x','1x'};
pairBtnGrid.Padding = [0 0 0 0];
pairBtnGrid.Layout.Row = 2;

app.AddPairButton = uibutton(pairBtnGrid, 'Text','Add Pair');
app.SwapPairButton = uibutton(pairBtnGrid, 'Text','Swap A/B');

% Compare checkbox
app.CompareFiltersCheckBox = uicheckbox(pairsGrid, ...
    'Text','Compare A/B Filters', 'Value',false);
app.CompareFiltersCheckBox.Layout.Row = 3;


%% ACCEL INFO SECTION
infoGrid = uigridlayout(app.AccelInfoContentPanel, [4 2]);
infoGrid.RowHeight = {'fit','fit','fit','fit'};
infoGrid.ColumnWidth = {'fit','1x'};
infoGrid.Padding = [0 0 0 0];
infoGrid.RowSpacing = 4;

uilabel(infoGrid, 'Text','Sensitivity:');
app.SensitivityField = uieditfield(infoGrid, 'numeric');

uilabel(infoGrid, 'Text','Units:');
app.UnitsField = uieditfield(infoGrid, 'text');

uilabel(infoGrid, 'Text','Calibration Date:');
app.CalibrationField = uieditfield(infoGrid, 'text');

uilabel(infoGrid, 'Text','Notes:');
app.AccelNotesField = uieditfield(infoGrid, 'text');


%% BAND SETTINGS SECTION
bandGrid = uigridlayout(app.BandContentPanel, [3 2]);
bandGrid.RowHeight = {'fit','1x','fit'};
bandGrid.ColumnWidth = {'fit','1x'};
bandGrid.Padding = [0 0 0 0];
bandGrid.RowSpacing = 4;

% Band start/end fields
uilabel(bandGrid, 'Text','Start (Hz):');
app.BandStartField = uieditfield(bandGrid, 'numeric');

uilabel(bandGrid, 'Text','End (Hz):');
app.BandEndField = uieditfield(bandGrid, 'numeric');

% Table (spans both columns)
app.BandTable = uitable(bandGrid, ...
    'ColumnName', {'Start (Hz)','End (Hz)'}, ...
    'ColumnEditable', [true true], ...
    'Data', {});
app.BandTable.Layout.Row = 2;
app.BandTable.Layout.Column = [1 2];

% Buttons row
bandBtnGrid = uigridlayout(bandGrid, [1 2]);
bandBtnGrid.ColumnWidth = {'1x','1x'};
bandBtnGrid.Padding = [0 0 0 0];
bandBtnGrid.Layout.Row = 3;
bandBtnGrid.Layout.Column = [1 2];

app.AddBandButton = uibutton(bandBtnGrid, 'Text','Add Band');
app.DeleteBandButton = uibutton(bandBtnGrid, 'Text','Delete Band');


%% BATCH PROCESSING SECTION
batchGrid = uigridlayout(app.BatchContentPanel, [1 1]);
batchGrid.RowHeight = {'fit'};
batchGrid.ColumnWidth = {'1x'};
batchGrid.Padding = [0 0 0 0];

app.RunBatchButton = uibutton(batchGrid, 'Text','Run Batch');


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



% Full callback wiring block
%% ------------------------------------------------------------
%  ACCELEROMETERS SECTION CALLBACKS
%% ------------------------------------------------------------

app.ReloadButton.ButtonPushedFcn = @(~,~) app.reloadWorkspace();
app.SelectAllButton.ButtonPushedFcn = @(~,~) app.selectAllAccelerometers();
app.ClearAllButton.ButtonPushedFcn = @(~,~) app.clearAllAccelerometers();

% Table edits (invert, axis, select)
app.AccelTable.CellEditCallback = @(src,evt) app.accelTableEdited(evt);

% Table selection (for Accel Info section)
app.AccelTable.SelectionChangedFcn = @(src,evt) app.accelTableSelectionChanged(evt);


%% ------------------------------------------------------------
%  TIME SEGMENTS SECTION CALLBACKS
%% ------------------------------------------------------------

app.ApplySegmentButton.ButtonPushedFcn = @(~,~) app.applyTimeSegment();

app.ShowAccelCheckBox.ValueChangedFcn = @(~,~) app.updateTimeHistories();
app.ShowVelocityCheckBox.ValueChangedFcn = @(~,~) app.updateTimeHistories();
app.ShowDisplacementCheckBox.ValueChangedFcn = @(~,~) app.updateTimeHistories();


%% ------------------------------------------------------------
%  RELATIVE PAIRS SECTION CALLBACKS
%% ------------------------------------------------------------

app.AddPairButton.ButtonPushedFcn = @(~,~) app.addPair();
app.SwapPairButton.ButtonPushedFcn = @(~,~) app.swapPair();

app.CompareFiltersCheckBox.ValueChangedFcn = @(~,~) app.updateTimeHistories();

% Table selection (for swap, delete, etc.)
app.PairTable.SelectionChangedFcn = @(src,evt) app.pairTableSelectionChanged(evt);


%% ------------------------------------------------------------
%  ACCEL INFO SECTION CALLBACKS
%% ------------------------------------------------------------

% These fields are usually read-only or updated automatically,
% but if you want to allow editing:
app.SensitivityField.ValueChangedFcn = @(~,~) app.updateAccelInfo();
app.UnitsField.ValueChangedFcn        = @(~,~) app.updateAccelInfo();
app.CalibrationField.ValueChangedFcn  = @(~,~) app.updateAccelInfo();
app.AccelNotesField.ValueChangedFcn   = @(~,~) app.updateAccelInfo();


%% ------------------------------------------------------------
%  BAND SETTINGS SECTION CALLBACKS
%% ------------------------------------------------------------

app.AddBandButton.ButtonPushedFcn    = @(~,~) app.addBand();
app.DeleteBandButton.ButtonPushedFcn = @(~,~) app.deleteBand();

% Table edits (start/end frequency)
app.BandTable.CellEditCallback = @(src,evt) app.bandTableEdited(evt);


%% ------------------------------------------------------------
%  BATCH PROCESSING SECTION CALLBACKS
%% ------------------------------------------------------------

app.RunBatchButton.ButtonPushedFcn = @(~,~) app.runBatch();


%% ------------------------------------------------------------
%  MENU BAR CALLBACKS
%% ------------------------------------------------------------

% File menu
app.FileMenuLoadWorkspace.MenuSelectedFcn = @(~,~) app.reloadWorkspace();
app.FileMenuExportPlot.MenuSelectedFcn    = @(~,~) app.exportPlot();

% Processing menu
app.MenuFFTSettings.MenuSelectedFcn = @(~,~) app.openFFTSettingsDialog();

% Preferences menu
app.MenuNormalization.MenuSelectedFcn = @(~,~) app.toggleNormalization();


%% ------------------------------------------------------------
%  TOOLBAR CALLBACKS
%% ------------------------------------------------------------

app.ToolbarReload.ClickedCallback = @(~,~) app.reloadWorkspace();
app.ToolbarAddPair.ClickedCallback = @(~,~) app.addPair();
app.ToolbarSwapPair.ClickedCallback = @(~,~) app.swapPair();
app.ToolbarExport.ClickedCallback = @(~,~) app.exportPlot();
