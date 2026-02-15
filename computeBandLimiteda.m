function BL = computeBandLimited(app, x, f)
    BL = struct();

    for k = 1:height(app.BandTable.Data)
        f0 = app.BandTable.Data.Low(k);
        f1 = app.BandTable.Data.High(k);

        idx = f >= f0 & f <= f1;

        BL(k).band = app.BandTable.Data.Name{k};
        BL(k).rms  = rms(x(idx));
        BL(k).max  = max(x(idx));
        BL(k).min  = min(x(idx));
        BL(k).mean = mean(x(idx));
    end
end
