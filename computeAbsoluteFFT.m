function F = computeAbsoluteFFT(app)
    F.a = app.computeFFT(app.curSignals.aF);
    F.v = app.computeFFT(app.curSignals.v);
    F.d = app.computeFFT(app.curSignals.d);
end