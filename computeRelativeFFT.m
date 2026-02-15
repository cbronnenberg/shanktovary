
function F = computeRelativeFFT(app)
    F.da = app.computeFFT(app.relSignals.daF);
    F.dv = app.computeFFT(app.relSignals.dv);
    F.dd = app.computeFFT(app.relSignals.dd);
end
