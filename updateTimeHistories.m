function updateTimeHistories(app)
%UPDATETIMEHISTORIES  Safely refresh the time‑domain plots in the app.
%
%   Merged version:
%       - Startup guards
%       - UI state reading
%       - Compare mode (A vs B)
%       - Normalization
%       - Time‑segment support (uses sig.t)
%       - Accel name in titles
%       - Statistics overlay (RMS / max / min)
%       - Safe deletion of axes only
%       - Tiled layout recreation
%       - Axis linking + interactivity

%% ------------------------------------------------------------------------
%  1. Startup Guards
% -------------------------------------------------------------------------
if isempty(app) || ~isvalid(app)
    return
end
if isempty(app.ShowAccelCheckBox) || ~isvalid(app.ShowAccelCheckBox)
    return
end
if isempty(app.TimeHistoryPanel) || ~isvalid(app.TimeHistoryPanel)
    return
end
if isempty(app.curSignals)
    return
end

%% ------------------------------------------------------------------------
%  2. Read UI State
% -------------------------------------------------------------------------
showA = app.ShowAccelCheckBox.Value;
showV = app.ShowVelocityCheckBox.Value;
showD = app.ShowDisplacementCheckBox.Value;

compareMode = app.CompareFiltersCheckBox.Value && ...
              ~isempty(app.ASignalsProcessed) && ...
              ~isempty(app.BSignalsProcessed);

% Use segmented time vector
t = app.curSignals.t;

%% ------------------------------------------------------------------------
%  3. Clear ONLY the plot area
% -------------------------------------------------------------------------
delete(findall(app.TimeHistoryPanel, 'Type', 'axes'));
delete(findall(app.TimeHistoryPanel, 'Type', 'tiledlayout'));

%% ------------------------------------------------------------------------
%  4. Create new tiledlayout
% -------------------------------------------------------------------------
tl = tiledlayout(app.TimeHistoryPanel, 3, 1, ...
    'TileSpacing', 'compact', ...
    'Padding', 'compact');

%% ------------------------------------------------------------------------
%  Determine accel name for titles
% -------------------------------------------------------------------------
row = app.AccelTable.Selection;
if isempty(row)
    row = 1;
end
accelName = app.AccelNames{row};

%% ------------------------------------------------------------------------
%  5. Plot Acceleration
% -------------------------------------------------------------------------
axA = nexttile(tl);

if showA
    if ~compareMode
        plot(axA, t, normalizeIfNeeded(app, app.curSignals.aF), 'k');
        title(axA, sprintf('Acceleration — %s', accelName));
    else
        plot(axA, t, normalizeIfNeeded(app, app.ASignalsProcessed.aF), 'k', ...
                 t, normalizeIfNeeded(app, app.BSignalsProcessed.aF), 'r');
        title(axA, sprintf('Acceleration (A vs B) — %s', accelName));
        legend(axA, {'A','B'});
    end
end
ylabel(axA, 'Accel');
addStatsOverlay(axA, t, app.curSignals.aF);

%% ------------------------------------------------------------------------
%  6. Plot Velocity
% -------------------------------------------------------------------------
axV = nexttile(tl);

if showV
    if ~compareMode
        plot(axV, t, normalizeIfNeeded(app, app.curSignals.v), 'b');
        title(axV, sprintf('Velocity — %s', accelName));
    else
        plot(axV, t, normalizeIfNeeded(app, app.ASignalsProcessed.v), 'b', ...
                 t, normalizeIfNeeded(app, app.BSignalsProcessed.v), 'm');
        title(axV, sprintf('Velocity (A vs B) — %s', accelName));
        legend(axV, {'A','B'});
    end
end
ylabel(axV, 'Velocity');
addStatsOverlay(axV, t, app.curSignals.v);

%% ------------------------------------------------------------------------
%  7. Plot Displacement
% -------------------------------------------------------------------------
axD = nexttile(tl);

if showD
    if ~compareMode
        plot(axD, t, normalizeIfNeeded(app, app.curSignals.d), 'r');
        title(axD, sprintf('Displacement — %s', accelName));
    else
        plot(axD, t, normalizeIfNeeded(app, app.ASignalsProcessed.d), 'r', ...
                 t, normalizeIfNeeded(app, app.BSignalsProcessed.d), 'c');
        title(axD, sprintf('Displacement (A vs B) — %s', accelName));
        legend(axD, {'A','B'});
    end
end
ylabel(axD, 'Disp');
xlabel(axD, 'Time (s)');
addStatsOverlay(axD, t, app.curSignals.d);

%% ------------------------------------------------------------------------
%  8. Link axes + enable interactivity
% -------------------------------------------------------------------------
linkaxes([axA axV axD], 'x');
enableDefaultInteractivity(axA);
enableDefaultInteractivity(axV);
enableDefaultInteractivity(axD);

end


%% ========================================================================
%  Helper: Normalization wrapper
% ========================================================================
function y = normalizeIfNeeded(app, y)
    if app.NormalizeCheckBox.Value
        m = max(abs(y));
        if m > 0
            y = y ./ m;
        end
    end
end


%% ========================================================================
%  Helper: Statistics overlay
% ========================================================================
function addStatsOverlay(ax, t, x)
    if isempty(x)
        return
    end

    rmsVal = sqrt(mean(x.^2));
    maxVal = max(x);
    minVal = min(x);

    txt = sprintf('RMS: %.3g\nMax: %.3g\nMin: %.3g', ...
        rmsVal, maxVal, minVal);

    delete(findall(ax,'Tag','StatsOverlay'));

    text(ax, 0.02, 0.95, txt, ...
        'Units','normalized', ...
        'HorizontalAlignment','left', ...
        'VerticalAlignment','top', ...
        'FontSize', 9, ...
        'BackgroundColor',[1 1 1 0.6], ...
        'EdgeColor','none', ...
        'Tag','StatsOverlay');
end
