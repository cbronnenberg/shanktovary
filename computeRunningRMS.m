function rr = computeRunningRMS(app, x)
    fs = app.fs;
    winSec = app.RunningRMSWindowField.Value;  % e.g., 0.1 s
    winSamples = max(1, round(winSec * fs));
    rr = sqrt(movmean(x.^2, winSamples));
end
