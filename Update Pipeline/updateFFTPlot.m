function updateFFTPlot(app)
%UPDATEFFTPLOT  Safely refresh the FFT plot.
%
%   Preserves:
%       - Startup guards
%       - Compare mode (A vs B)
%       - Panel-safe deletion (axes + tiledlayout only)
%       - applyPlotStyle usage
%   Uses:
%       - app.curSignals.aUS, .v, .d
%       - app.ASignalsProcessed, app.BSignalsProcessed
%       - app.FFTPanel, app.NfftField

%% Guards
if isempty(app) || ~isvalid(app)
    return
end
if isempty(app.FFTPanel) || ~isvalid(app.FFTPanel)
    return
end
if isempty(app.curSignals)
    return
end

%% Read state
t   = app.t;
fs  = 1 / mean(diff(t));
Nfft = app.NfftField.Value;

compareMode = app.CompareFiltersCheckBox.Value && ...
              ~isempty(app.ASignalsProcessed) && ...
              ~isempty(app.BSignalsProcessed);

%% Clear plot area only
oldAxes = findall(app.FFTPanel, 'Type', 'axes');
delete(oldAxes);
oldTL = findall(app.FFTPanel, 'Type', 'tiledlayout');
delete(oldTL);

%% Layout
tl = tiledlayout(app.FFTPanel, 1, 1, ...
    'TileSpacing','compact', ...
    'Padding','compact');
ax = nexttile(tl);
hold(ax,'on');

%% Primary (A) spectra
aUS = app.curSignals.aUS;
v   = app.curSignals.v;
d   = app.curSignals.d;

A = fft(aUS, Nfft);
V = fft(v,   Nfft);
D = fft(d,   Nfft);

f = (0:Nfft-1)' * (fs/Nfft);

loglog(ax, f, abs(A), 'k', 'LineWidth', 1.2);
loglog(ax, f, abs(V), 'b', 'LineWidth', 1.2);
loglog(ax, f, abs(D), 'r', 'LineWidth', 1.2);

%% Compare (B) spectra
if compareMode
    aUSB = app.BSignalsProcessed.aUS;
    vB   = app.BSignalsProcessed.v;
    dB   = app.BSignalsProcessed.d;

    AB = fft(aUSB, Nfft);
    VB = fft(vB,   Nfft);
    DB = fft(dB,   Nfft);

    loglog(ax, f, abs(AB), '--k', 'LineWidth', 1.0);
    loglog(ax, f, abs(VB), '--b', 'LineWidth', 1.0);
    loglog(ax, f, abs(DB), '--r', 'LineWidth', 1.0);
end

%% Labels, limits, legend
xlim(ax, [1 2000]);
xlabel(ax, 'Frequency (Hz)');
ylabel(ax, 'Magnitude');
title(ax, 'Spectral Growth Through Integration');

if compareMode
    legend(ax, {'Accel A','Vel A','Disp A', ...
                'Accel B','Vel B','Disp B'}, 'Location','best');
else
    legend(ax, {'Accel','Vel','Disp'}, 'Location','best');
end

applyPlotStyle(app, ax, '', 'Frequency (Hz)', 'Magnitude', {});

end
