function [tOut, aOut] = segmentSignal(app, t, a)
    t0 = app.StartTimeField.Value;
    t1 = app.EndTimeField.Value;

    if isnan(t0) || isnan(t1)
        tOut = t;
        aOut = a;
        return;
    end

    idx = t >= t0 & t <= t1;
    tOut = t(idx);
    aOut = a(idx);
end
