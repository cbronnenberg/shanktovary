function loadRelativeSignalsIntoApp(app, t, a1, a2, axis1, axis2, inv1, inv2)
    % Apply inversion
    if inv1, a1 = -a1; end
    if inv2, a2 = -a2; end

    % Convert to SI
    a1 = app.convertAccelToSI(a1);
    a2 = app.convertAccelToSI(a2);

    % Segment
    [tSeg, a1Seg] = app.segmentSignal(t, a1);
    [~,    a2Seg] = app.segmentSignal(t, a2);

    % Compute relative acceleration
    da = app.computeRelativeAcceleration(a1Seg, a2Seg, axis1, axis2);

    % Store
    app.rel.t = tSeg;
    app.rel.da = da;

    % Compute filtered + integrated relative signals
    app.computeRelativeSignals();

    % Update UI
    app.ProcessingMode = "Relative";
    app.updateStatusBar();
end
