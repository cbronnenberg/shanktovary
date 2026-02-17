function updateFFTPlot(app)
%UPDATEFFTPLOT  Safely refresh the FFT plot.
%
%   This version merges:
%       - Your original guarded implementation
%       - A/B comparison mode
%       - Panel-safe deletion
%       - New processing pipeline (curSignals, ASignalsProcessed, BSignalsProcessed)
%       - FFT length dropdown (with fallback to app.Nfft)
%       - applyPlotStyle usage
%
%   It does NOT introduce new properties and does NOT break existing UI.

%% ------------------------------------------------------------------------
%  1. Startup Guards
% -------------------------------------------------------------------------
if isempty(app) || ~isvalid(app)
    return
end

if isempty(app.FFTPanel) || ~isvalid(app.FFTPanel)
    return
end

if isempty(app.curSignals)
    return
end

%% ------------------------------------------------------------------------
%  2. Determine FFT Length (safe, dropdown-first)
% -------------------------------------------------------------------------
if isprop(app,'NfftDropDown') && ~isempty(app.NfftDropDown) && isvalid(app.NfftDropDown)
    Nfft = str2double(app.NfftDropDown.Value);
elseif isprop(app,'Nfft')
    Nfft = app.Nfft;   % fallback to old property
else
    Nfft = 8192;       % absolute fallback
end

%% ------------------------------------------------------------------------
%  3. Read primary signal (A)
% -------------------------------------------------------------------------
t   = app.t;
fs  = 1 / mean(diff(t));

aUS = app.curSignals.aUS;   % accel in US units (in/s^2)
v   = app.curSignals.v;     % velocity (in/s)
d   = app.curSignals.d;     % displacement (in)

% Compute FFTs
A = fft(aUS, Nfft);
V = fft(v,   Nfft);
D = fft(d,   Nfft);

f = (0:Nfft-1)' * (fs/Nfft);

%% ------------------------------------------------------------------------
%  4. Compare Mode (A vs B)
% -------------------------------------------------------------------------
compareMode = app.CompareFiltersCheckBox.Value && ...
              ~isempty(app.ASignalsProcessed) && ...
              ~isempty(app.BSignalsProcessed);

%% ------------------------------------------------------------------------
%  5. Clear ONLY the plot area (axes + tiledlayout)
% -------------------------------------------------------------------------
oldAxes = findall(app.FFTPanel, 'Type', 'axes');
delete(oldAxes);

oldTL = findall(app.FFTPanel, 'Type', 'tiledlayout');
delete(oldTL);

%% ------------------------------------------------------------------------
%  6. Create new tiledlayout
% -------------------------------------------------------------------------
tl = tiledlayout(app.FFTPanel, 1, 1, ...
    'TileSpacing','compact', ...
    'Padding','compact');

ax = nexttile(tl);
hold(ax,'on');

%% ------------------------------------------------------------------------
%  7. Plot Primary (A) Spectra
% -------------------------------------------------------------------------
loglog(ax, f, abs(A), 'k', 'LineWidth', 1.2);
loglog(ax, f, abs(V), 'b', 'LineWidth', 1.2);
loglog(ax, f, abs(D), 'r', 'LineWidth', 1.2);

%% ------------------------------------------------------------------------
%  8. Plot Compare (B) Spectra
% -------------------------------------------------------------------------
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

%% ------------------------------------------------------------------------
%  9. Labels, Limits, Legend
% -------------------------------------------------------------------------
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

%% ------------------------------------------------------------------------
% 10. Apply Styling
% -------------------------------------------------------------------------
applyPlotStyle(app, ax, '', 'Frequency (Hz)', 'Magnitude', {});

end
