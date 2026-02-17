function updatePSDPlot(app)
%UPDATEPSDPLOT  Safely refresh the PSD plot.
%
%   Preserves:
%       - Startup guards
%       - Compare mode (A vs B)
%       - Panel-safe deletion
%   Uses:
%       - app.curSignals.aUS
%       - app.BSignalsProcessed.aUS
%       - app.PSDPanel

%% Guards
if isempty(app) || ~isvalid(app)
    return
end
if isempty(app.PSDPanel) || ~isvalid(app.PSDPanel)
    return
end
if isempty(app.curSignals)
    return
end

%% Read state
t  = app.t;
fs = 1 / mean(diff(t));

compareMode = app.CompareFiltersCheckBox.Value && ...
              ~isempty(app.ASignalsProcessed) && ...
              ~isempty(app.BSignalsProcessed);

%% Clear plot area only
oldAxes = findall(app.PSDPanel, 'Type', 'axes');
delete(oldAxes);
oldTL = findall(app.PSDPanel, 'Type', 'tiledlayout');
delete(oldTL);

%% Layout
tl = tiledlayout(app.PSDPanel, 1, 1, ...
    'TileSpacing','compact', ...
    'Padding','compact');
ax = nexttile(tl);
hold(ax,'on');

%% Primary (A) PSD
aUS = app.curSignals.aUS;

win  = hanning(2048);
nfft = 4096;

[Pxx, f] = pwelch(aUS, win, [], nfft, fs);
loglog(ax, f, sqrt(Pxx), 'k', 'LineWidth', 1.2);

%% Compare (B) PSD
if compareMode
    aUSB = app.BSignalsProcessed.aUS;
    [PxxB, fB] = pwelch(aUSB, win, [], nfft, fs);
    loglog(ax, fB, sqrt(PxxB), '--k', 'LineWidth', 1.0);
end

xlabel(ax, 'Frequency (Hz)');
ylabel(ax, 'ASD (in/s^2 / sqrt(Hz))');
title(ax, 'Acceleration PSD');
xlim(ax, [1 2000]);

applyPlotStyle(app, ax, '', 'Frequency (Hz)', 'ASD', {});

end
