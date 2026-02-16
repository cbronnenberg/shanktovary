function setCurrentSignalFromIndex(app, idx)
% helper function to set the current signal based on the index of the selected accelerometer
    if isempty(app.AccelSignals) || idx < 1 || idx > numel(app.AccelSignals)
        return;
    end

    raw = app.AccelSignals{idx}; % Convert to in/s^2 for internal processing
    aF = app.convertAccelUnitsToInternal(raw);
    
    sig = app.AccelSignals{idx};
    t   = app.t;

    v = cumtrapz(t, sig);
    d = cumtrapz(t, v);

    app.curSignals = struct( ...
        'aF', sig, ...
        'v',  v, ...
        'd',  d);

end
