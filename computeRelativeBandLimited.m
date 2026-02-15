function BL = computeRelativeBandLimited(app)
    PSD = app.computeRelativePSD();
    BL = app.computeBandLimited(PSD.dd.Pxx, PSD.dd.f);
end
