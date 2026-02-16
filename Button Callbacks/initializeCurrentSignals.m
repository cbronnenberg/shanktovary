function initializeCurrentSignals(app, data)

    app.t = data.t;

    % Default: use the first accelerometer
    sig = data.accelSignals{1};

    % Compute velocity and displacement
    v = cumtrapz(app.t, sig);
    d = cumtrapz(app.t, v);

    app.curSignals = struct( ...
        'aF', sig, ...
        'v',  v, ...
        'd',  d);

    % A/B signals empty until user selects compare mode
    app.ASignals = [];
    app.BSignals = [];

    app.StartTimeField.Value = app.t(1);
    app.EndTimeField.Value   = app.t(end);


end
