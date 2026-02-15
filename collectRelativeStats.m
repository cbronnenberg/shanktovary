function S = collectRelativeStats(app, name1, name2)
    S.Pair = sprintf('%s_minus_%s', name1, name2);

    S.RMS_rel = rms(app.relSignals.dd);
    S.Max_rel = max(app.relSignals.dd);
    S.Min_rel = min(app.relSignals.dd);
    S.Mean_rel = mean(app.relSignals.dd);

    BL = app.computeRelativeBandLimited();
    for k = 1:numel(BL)
        S.(sprintf('BL_%s_RMS', BL(k).band)) = BL(k).rms;
    end
end
