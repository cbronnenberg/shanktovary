function BL = computeAbsoluteBandLimited(app)
    PSD = app.computeAbsolutePSD();
    BL = app.computeBandLimited(PSD.d.Pxx, PSD.d.f);
end
