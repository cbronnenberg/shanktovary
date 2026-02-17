function updatePSDPlot(app)
%UPDATEPSDPLOT  Full 3×2 PSD + RMS layout with compare mode.
%
%   Restores:
%       - Accel PSD + RMS
%       - Velocity PSD + RMS
%       - Displacement PSD + RMS
%
%   Uses:
%       - Welch PSD (window %, overlap %, Nfft)
%       - app.curSignals.{aUS, v, d}
%       - app.ASignalsProcessed / app.BSignalsProcessed
%       - CompareFiltersCheckBox
%
%   Preserves:
%       - Startup guards
%       - Panel-safe deletion
%       - Compare mode (A vs B)

%% ------------------------------------------------------------
%  Guards
%% ------------------------------------------------------------
if isempty(app) || ~isvalid(app)
    return
end
if isempty(app.PSDPanel) || ~isvalid(app.PSDPanel)
    return
end
if isempty(app.curSignals)
    return
end

%% ------------------------------------------------------------
%  Read state
%% ------------------------------------------------------------
t  = app.t(:);
fs = 1 / mean(diff(t));

compareMode = app.CompareFiltersCheckBox.Value && ...
              ~isempty(app.ASignalsProcessed) && ...
              ~isempty(app.BSignalsProcessed);

%% ------------------------------------------------------------
%  Extract primary (A) signals
%% ------------------------------------------------------------
aA = app.curSignals.aUS;   % accel (internal)
vA = app.curSignals.v;     % velocity (internal)
dA = app.curSignals.d;     % displacement (internal)

%% ------------------------------------------------------------
%  Compute PSDs (Welch)
%% ------------------------------------------------------------
[fA_a, PxxA_a] = computePSD(app, aA, fs);
[fA_v, PxxA_v] = computePSD(app, vA, fs);
[fA_d, PxxA_d] = computePSD(app, dA, fs);

%% ------------------------------------------------------------
%  Compute cumulative RMS
%% ------------------------------------------------------------
rmsA_a = computeCumulativeRMS(app, fA_a, PxxA_a);
rmsA_v = computeCumulativeRMS(app, fA_v, PxxA_v);
rmsA_d = computeCumulativeRMS(app, fA_d, PxxA_d);

%% ------------------------------------------------------------
%  Compare mode (B)
%% ------------------------------------------------------------
if compareMode
    aB = app.BSignalsProcessed.aUS;
    vB = app.BSignalsProcessed.v;
    dB = app.BSignalsProcessed.d;

    [fB_a, PxxB_a] = computePSD(app, aB, fs);
    [fB_v, PxxB_v] = computePSD(app, vB, fs);
    [fB_d, PxxB_d] = computePSD(app, dB, fs);

    rmsB_a = computeCumulativeRMS(app, fB_a, PxxB_a);
    rmsB_v = computeCumulativeRMS(app, fB_v, PxxB_v);
    rmsB_d = computeCumulativeRMS(app, fB_d, PxxB_d);
end

%% ------------------------------------------------------------
%  Clear panel
%% ------------------------------------------------------------
delete(findall(app.PSDPanel, 'Type','axes'));
delete(findall(app.PSDPanel, 'Type','tiledlayout'));

%% ------------------------------------------------------------
%  Create 3×2 layout
%% ------------------------------------------------------------
tl = tiledlayout(app.PSDPanel, 3, 2, ...
    'TileSpacing','compact', ...
    'Padding','compact');

%% ------------------------------------------------------------
%  1. Accel PSD
%% ------------------------------------------------------------
ax1 = nexttile(tl, 1);
loglog(ax1, fA_a, PxxA_a, 'k', 'LineWidth', 1.2);
if compareMode
    loglog(ax1, fB_a, PxxB_a, '--k', 'LineWidth', 1.0);
end
grid(ax1,'on');
xlabel(ax1,'Hz');
ylabel(ax1,'PSD');
title(ax1,'Accel PSD');

%% ------------------------------------------------------------
%  2. Accel RMS
%% ------------------------------------------------------------
ax2 = nexttile(tl, 2);
semilogx(ax2, fA_a, rmsA_a, 'k', 'LineWidth', 1.2);
if compareMode
    semilogx(ax2, fB_a, rmsB_a, '--k', 'LineWidth', 1.0);
end
grid(ax2,'on');
xlabel(ax2,'Hz');
ylabel(ax2,'RMS');
title(ax2,'Accel RMS');

%% ------------------------------------------------------------
%  3. Velocity PSD
%% ------------------------------------------------------------
ax3 = nexttile(tl, 3);
loglog(ax3, fA_v, PxxA_v, 'b', 'LineWidth', 1.2);
if compareMode
    loglog(ax3, fB_v, PxxB_v, '--b', 'LineWidth', 1.0);
end
grid(ax3,'on');
xlabel(ax3,'Hz');
ylabel(ax3,'PSD');
title(ax3,'Velocity PSD');

%% ------------------------------------------------------------
%  4. Velocity RMS
%% ------------------------------------------------------------
ax4 = nexttile(tl, 4);
semilogx(ax4, fA_v, rmsA_v, 'b', 'LineWidth', 1.2);
if compareMode
    semilogx(ax4, fB_v, rmsB_v, '--b', 'LineWidth', 1.0);
end
grid(ax4,'on');
xlabel(ax4,'Hz');
ylabel(ax4,'RMS');
title(ax4,'Velocity RMS');

%% ------------------------------------------------------------
%  5. Displacement PSD
%% ------------------------------------------------------------
ax5 = nexttile(tl, 5);
loglog(ax5, fA_d, PxxA_d, 'r', 'LineWidth', 1.2);
if compareMode
    loglog(ax5, fB_d, PxxB_d, '--r', 'LineWidth', 1.0);
end
grid(ax5,'on');
xlabel(ax5,'Hz');
ylabel(ax5,'PSD');
title(ax5,'Displacement PSD');

%% ------------------------------------------------------------
%  6. Displacement RMS
%% ------------------------------------------------------------
ax6 = nexttile(tl, 6);
semilogx(ax6, fA_d, rmsA_d, 'r', 'LineWidth', 1.2);
if compareMode
    semilogx(ax6, fB_d, rmsB_d, '--r', 'LineWidth', 1.0);
end
grid(ax6,'on');
xlabel(ax6,'Hz');
ylabel(ax6,'RMS');
title(ax6,'Displacement RMS');

end
