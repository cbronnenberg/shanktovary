function rmsCurve = computeCumulativeRMS(app, f, Pxx)
%COMPUTECUMULATIVERMS  Integrate PSD to cumulative RMS.

    df = mean(diff(f));
    rmsCurve = sqrt(cumtrapz(f, Pxx));

end
