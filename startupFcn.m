%% startupFcn.m

function startupFcn(app, accel, fs)
    % Core data
    app.a  = accel(:);
    app.fs = fs;
    app.t  = (0:length(accel)-1)'/fs;

    % Default control values (optional, but explicit)
    app.HPField.Value    = 10;
    app.LPField.Value    = 2000;
    app.OrderField.Value = 6;

    % Default bands
    app.BandTable.Data = [5 10; 10 20; 20 50; 50 200; 200 2000];

% === FILE MENU ===
mFile = uimenu(app.UIFigure, 'Text', 'File');
uimenu(mFile, 'Text', 'Reload Workspace', 'MenuSelectedFcn', @(~,~)app.reloadAccelList());
uimenu(mFile, 'Text', 'Export All Plots', 'MenuSelectedFcn', @(~,~)app.exportAllPlotsForCurrentSignal('manual'));
uimenu(mFile, 'Text', 'Export Stats Table', 'MenuSelectedFcn', @(~,~)app.exportStatsTable());
uimenu(mFile, 'Text', 'Exit', 'MenuSelectedFcn', @(~,~)close(app.UIFigure));

% === PROCESSING MENU ===
mProc = uimenu(app.UIFigure, 'Text', 'Processing');
uimenu(mProc, 'Text', 'Absolute Mode', 'MenuSelectedFcn', @(~,~)app.setProcessingMode('Absolute'));
uimenu(mProc, 'Text', 'Relative Mode', 'MenuSelectedFcn', @(~,~)app.setProcessingMode('Relative'));
uimenu(mProc, 'Text', 'Batch Mode', 'MenuSelectedFcn', @(~,~)app.setProcessingMode('Batch'));

% === PREFERENCES MENU ===
mPrefs = uimenu(app.UIFigure, 'Text', 'Preferences');
uimenu(mPrefs, 'Text', 'Units...', 'MenuSelectedFcn', @(~,~)app.openUnitsDialog());
uimenu(mPrefs, 'Text', 'FFT Settings...', 'MenuSelectedFcn', @(~,~)app.openFFTDialog());
uimenu(mPrefs, 'Text', 'Axis Detection...', 'MenuSelectedFcn', @(~,~)app.openAxisDetectionDialog());

% === TOOLS MENU ===
mTools = uimenu(app.UIFigure, 'Text', 'Tools');
uimenu(mTools, 'Text', 'Swap A/B', 'MenuSelectedFcn', @(~,~)app.swapSelectedPair());
uimenu(mTools, 'Text', 'Detect Axes from Names', 'MenuSelectedFcn', @(~,~)app.detectAxesForAll());
uimenu(mTools, 'Text', 'Invert Selected Channel', 'MenuSelectedFcn', @(~,~)app.invertSelectedAccel());
uimenu(mTools, 'Text', 'Clear Relative Pairs', 'MenuSelectedFcn', @(~,~)app.clearRelativePairs());

% === HELP MENU ===
mHelp = uimenu(app.UIFigure, 'Text', 'Help');
uimenu(mHelp, 'Text', 'About', 'MenuSelectedFcn', @(~,~)app.showAboutDialog());


tb = uitoolbar(app.UIFigure);

% Reload Workspace
iconReload = matlab.ui.internal.toolstrip.Icon.RELOAD_24;
uipushtool(tb, 'Tooltip', 'Reload Workspace', ...
    'ClickedCallback', @(~,~)app.reloadAccelList(), ...
    'Icon', iconReload.getIcon());

% Add Pair
iconAdd = matlab.ui.internal.toolstrip.Icon.ADD_24;
uipushtool(tb, 'Tooltip', 'Add Relative Pair', ...
    'ClickedCallback', @(~,~)app.addPairFromSelection(), ...
    'Icon', iconAdd.getIcon());

% Swap A/B
iconSwap = matlab.ui.internal.toolstrip.Icon.SWITCH_24;
uipushtool(tb, 'Tooltip', 'Swap A/B', ...
    'ClickedCallback', @(~,~)app.swapSelectedPair(), ...
    'Icon', iconSwap.getIcon());

% Export Plots
iconExport = matlab.ui.internal.toolstrip.Icon.EXPORT_24;
uipushtool(tb, 'Tooltip', 'Export Plots', ...
    'ClickedCallback', @(~,~)app.exportAllPlotsForCurrentSignal('manual'), ...
    'Icon', iconExport.getIcon());

% Preferences
iconPrefs = matlab.ui.internal.toolstrip.Icon.SETTINGS_24;
uipushtool(tb, 'Tooltip', 'Preferences', ...
    'ClickedCallback', @(~,~)app.openPreferencesDialog(), ...
    'Icon', iconPrefs.getIcon());

end
