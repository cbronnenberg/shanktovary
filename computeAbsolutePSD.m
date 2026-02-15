function PSD = computeAbsolutePSD(app)
    PSD.a = app.computePSD(app.curSignals.aF);
    PSD.v = app.computePSD(app.curSignals.v);
    PSD.d = app.computePSD(app.curSignals.d);
end
