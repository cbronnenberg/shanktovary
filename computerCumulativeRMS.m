function cum = computeCumulativeRMS(~, f, Pxx)
    cum = sqrt(cumtrapz(f, Pxx));
end
