function [win, overlap, Nfft] = getFFTParams(app)
    Nfft = app.FFTSizeDropDown.Value;
    winPct = app.WindowPercentField.Value / 100;
    ovlPct = app.OverlapPercentField.Value / 100;

    win = hamming(round(Nfft * winPct));
    overlap = round(length(win) * ovlPct);
end
