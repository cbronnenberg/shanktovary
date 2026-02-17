function handleAccelSelect(app, row)

    raw = app.AccelSignals{row};
    t   = app.t;

    % Process accel → filtered accel → vel → disp
    sig = processSignal(app, raw, t);

    app.curSignals = sig;

    updateAccelInfo(app);

    app.StartTimeField.Value = t(1);
    app.EndTimeField.Value   = t(end);

    refreshAllPlots(app);

end
