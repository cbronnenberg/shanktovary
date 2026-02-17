function applyTimeSegment(app)
%APPLYTIMESEGMENT  Slice current signal using Start/End fields and update app.curSignals.

    if isempty(app.curSignals) || isempty(app.t)
        return
    end

    t = app.t(:);
    tStart = app.StartTimeField.Value;
    tEnd   = app.EndTimeField.Value;

    % Clamp
    tStart = max(tStart, t(1));
    tEnd   = min(tEnd,   t(end));

    idx = (t >= tStart) & (t <= tEnd);

    % Slice
    sig = app.curSignals;
    sig.aUS = sig.aUS(idx);
    sig.aF  = sig.aF(idx);
    sig.v   = sig.v(idx);
    sig.d   = sig.d(idx);
    sig.t   = t(idx);

    % Update app state
    app.curSignals = sig;

    % Refresh plots
    refreshAllPlots(app);
end
