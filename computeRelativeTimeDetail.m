function TH = computeRelativeTimeDetail(app)
    t = app.rel.t;

    TH.da = app.relSignals.da;
    TH.dv = app.relSignals.dv;
    TH.dd = app.relSignals.dd;

    TH.rr_da = app.computeRunningRMS(TH.da);
    TH.rr_dv = app.computeRunningRMS(TH.dv);
    TH.rr_dd = app.computeRunningRMS(TH.dd);

    TH.cum_da = app.computeTimeCumulativeRMS(t, TH.da);
    TH.cum_dv = app.computeTimeCumulativeRMS(t, TH.dv);
    TH.cum_dd = app.computeTimeCumulativeRMS(t, TH.dd);
end
