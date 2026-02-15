function computeSignals(app)
    a = app.sig.a;
    fs = app.fs;

    % Filter
    aF = app.applyFilter(a);

    % Integrate
    v = app.integrateFD(aF, fs, 1);
    d = app.integrateFD(aF, fs, 2);

    % Store
    app.curSignals.a  = a;
    app.curSignals.aF = aF;
    app.curSignals.v  = v;
    app.curSignals.d  = d;
end
