function loadSignalIntoApp(app, t, a, axis, invert)
    % Store raw
    app.raw.t = t(:);
    app.raw.a = a(:);

    % Apply inversion
    if invert
        a = -a;
    end

    % Convert to SI
    a = app.convertAccelToSI(a);

    % Store axis
    app.raw.axis = axis;

    % Compute sampling rate
    app.fs = 1 / mean(diff(t));

    % Apply time segmentation
    [tSeg, aSeg] = app.segmentSignal(t, a);

    % Store segmented
    app.sig.t = tSeg;
    app.sig.a = aSeg;

    % Compute filtered + integrated signals
    app.computeSignals();

    % Update UI
    app.ProcessingMode = "Absolute";
    app.updateStatusBar();
end
