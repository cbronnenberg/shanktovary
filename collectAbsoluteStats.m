function S = collectAbsoluteStats(app, name)
    S.Name = name;

    S.RMS_a = rms(app.curSignals.a);
    S.RMS_v = rms(app.curSignals.v);
    S.RMS_d = rms(app.curSignals.d);

    S.Max_d = max(app.curSignals.d);
    S.Min_d = min(app.curSignals.d);
    S.Mean_d = mean(app.curSignals.d);

    % band-limited stats
    BL = app.computeAbsoluteBandLimited();
    for k = 1:numel(BL)
        S.(sprintf('BL_%s_RMS', BL(k).band)) = BL(k).rms;
    end
end
