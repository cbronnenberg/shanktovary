function cum = computeTimeCumulativeRMS(~, t, x)
    dt = t - t(1);
    cum = sqrt(cumtrapz(t, x.^2) ./ max(dt, eps));
end
