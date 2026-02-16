function setCurrentSignalFromIndex(app, idx)

    if isempty(app.AccelSignals) || idx < 1 || idx > numel(app.AccelSignals)
        return;
    end

    raw = app.AccelSignals{idx};

    % Convert to US units for internal processing
    aF = convertAccelUnitsToInternal(app, raw);

    t = app.t;

    % Integrate
    v = cumtrapz(t, aF);
    d = cumtrapz(t, v);

    % Store internal signals
    app.curSignals = struct( ...
        'aF', aF, ...
        'v',  v, ...
        'd',  d);

    % --- NEW: Auto‑populate time segment fields ---
    app.StartTimeField.Value = t(1);
    app.EndTimeField.Value   = t(end);

end
