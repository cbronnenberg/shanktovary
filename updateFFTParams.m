function updateFFTParams(app)

    if ~isvalid(app)
        return;
    end

    % Read dropdown
    app.Nfft = str2double(app.NfftDropDown.Value);

    % Read window and overlap percentages
    app.WindowPct  = app.WindowPctField.Value;
    app.OverlapPct = app.OverlapPctField.Value;

    % Compute window length in samples
    app.WindowLength = round(app.WindowPct/100 * app.Nfft);

    % Compute overlap in samples
    app.OverlapLength = round(app.OverlapPct/100 * app.WindowLength);

    % Refresh all spectral plots
    app.updateFFTPlot();
    app.updateSpectrogramPlot();
    app.updatePSDPlot();
    app.updateBandPlot();

end