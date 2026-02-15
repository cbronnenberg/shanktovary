function applyTimeSegment(app)
    % Read start/end times from UI
    tStart = app.StartTimeField.Value;
    tEnd   = app.EndTimeField.Value;

    % Validate
    if tStart >= tEnd
        uialert(app.UIFigure, 'Start time must be less than end time.', 'Invalid Range');
        return;
    end

    % Slice the time vector
    idx = app.TimeVector >= tStart & app.TimeVector <= tEnd;

    app.SegTimeVector = app.TimeVector(idx);

    % Slice each selected accelerometer signal
    for k = 1:numel(app.SelectedSignals)
        sig = app.SelectedSignals{k};
        app.SegSignals{k} = sig(idx);
    end

    % Trigger the update pipeline
    app.updateTimePlot();
    app.updateFFTPlot();
    app.updateSpectrogramPlot();
end

% app.ApplySegmentButton.ButtonPushedFcn = @(~,~) app.applyTimeSegment();
