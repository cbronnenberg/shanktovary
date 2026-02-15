function TH = computeAbsoluteTimeDetail(app)
    t = app.sig.t;

    TH.a = app.curSignals.a;
    TH.v = app.curSignals.v;
    TH.d = app.curSignals.d;

    TH.rr_a = app.computeRunningRMS(TH.a);
    TH.rr_v = app.computeRunningRMS(TH.v);
    TH.rr_d = app.computeRunningRMS(TH.d);

    TH.cum_a = app.computeTimeCumulativeRMS(t, TH.a);
    TH.cum_v = app.computeTimeCumulativeRMS(t, TH.v);
    TH.cum_d = app.computeTimeCumulativeRMS(t, TH.d);
end
