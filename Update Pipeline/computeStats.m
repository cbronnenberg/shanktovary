function stats = computeStats(~, x)
    stats.rms = rms(x);
    stats.max = max(x);
    stats.min = min(x);
end
