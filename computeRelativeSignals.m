function computeRelativeSignals(app)
    da = app.rel.da;
    fs = app.fs;

    % Filter
    daF = app.applyFilter(da);

    % Integrate
    dv = app.integrateFD(daF, fs, 1);
    dd = app.integrateFD(daF, fs, 2);

    % Store
    app.relSignals.da  = da;
    app.relSignals.daF = daF;
    app.relSignals.dv  = dv;
    app.relSignals.dd  = dd;
end
