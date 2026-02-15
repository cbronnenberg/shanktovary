function PSD = computeRelativePSD(app)
    PSD.da = app.computePSD(app.relSignals.daF);
    PSD.dv = app.computePSD(app.relSignals.dv);
    PSD.dd = app.computePSD(app.relSignals.dd);
end
