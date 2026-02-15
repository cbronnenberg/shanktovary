methods (Access = private)
    
    function reloadWorkspace(app)
        % This is the callback for the Reload Workspace button

        % Step 1: Reload data from MATLAB workspace
        [app.AccelList, app.TimeVector, app.TimeSignal] = loadWorkspaceData(); % Your custom function

        % Step 2: Populate the accelerometer dropdown
        app.AccelDropdown.Items = app.AccelList;

        % Step 3: Clear all plots
        app.clearAllPlots();

        % Step 4: Notify user (optional)
        uialert(app.UIFigure, 'Workspace reloaded successfully!', 'Success', 'Icon', 'success');
    end

end

% in startupFcn:
% app.ReloadButton.ButtonPushedFcn = @(~,~) app.reloadWorkspace();