function updateFFTPlot(app)
%UPDATEFFTPLOT  Refresh the FFT plot in the app.

%% Startup guards
if isempty(app) || ~isvalid(app)
    return
end
if isempty(app.FFTPanel) || ~isvalid(app.FFTPanel)
    return
end
if isempty(app.curSignals) || isempty(app.curSignals.Amp)
    return
end

%% Read UI state
compareMode = app.CompareFiltersCheckBox.Value && ...
              ~isempty(app.ASignals) && ~isempty(app.BSignals);

%% Clear only axes/tiledlayouts
delete(findall(app.FFTPanel, 'Type', 'axes'));
delete(findall(app.FFTPanel, 'Type', 'tiledlayout'));

%% Create layout
tl = tiledlayout(app.FFTPanel, 1, 1, ...
    'TileSpacing', 'compact', ...
    'Padding', 'compact');

ax = nexttile(tl);

%% Plot
if ~compareMode
    plot(ax, app.curSignals.f, app.curSignals.Amp, 'k');
    title(ax, 'FFT Amplitude');
else
    plot(ax, app.ASignals.f, app.ASignals.Amp, 'k', ...
             app.BSignals.f, app.BSignals.Amp, 'r');
    title(ax, 'FFT Amplitude (A vs B)');
    legend(ax, {'A','B'});
end

xlabel(ax, 'Frequency (Hz)');
ylabel(ax, 'Amplitude');
grid(ax, 'on');
enableDefaultInteractivity(ax);

end
