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
