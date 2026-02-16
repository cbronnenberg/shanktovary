function updateTimeHistories(app)
%UPDATETIMEHISTORIES  Safely refresh the time‑domain plots in the app.
%
%   This version is designed to live OUTSIDE the .mlapp file.
%   It assumes:
%       - app.TimeHistoryPanel is a PUBLIC property
%       - app.ShowAccelCheckBox, ShowVelocityCheckBox, ShowDisplacementCheckBox
%         are PUBLIC properties
%       - app.NormalizeCheckBox is PUBLIC
%       - app.curSignals, app.ASignals, app.BSignals exist
%       - app.t exists

%% ------------------------------------------------------------------------
%  1. Startup Guards (prevent early firing)
% -------------------------------------------------------------------------
if isempty(app) || ~isvalid(app)
    return
end

% If UI controls are not yet created, bail out
if isempty(app.ShowAccelCheckBox) || ~isvalid(app.ShowAccelCheckBox)
    return
end

if isempty(app.TimeHistoryPanel) || ~isvalid(app.TimeHistoryPanel)
    return
end

%% ------------------------------------------------------------------------
%  2. Read UI State
% -------------------------------------------------------------------------
showA = app.ShowAccelCheckBox.Value;
showV = app.ShowVelocityCheckBox.Value;
showD = app.ShowDisplacementCheckBox.Value;

compareMode = app.CompareFiltersCheckBox.Value && ...
              ~isempty(app.ASignals) && ~isempty(app.BSignals);

t = app.t;

%% ------------------------------------------------------------------------
%  3. Clear ONLY the plot area (NOT the entire panel)
% -------------------------------------------------------------------------
% Delete only axes, not UI controls
oldAxes = findall(app.TimeHistoryPanel, 'Type', 'axes');
delete(oldAxes);

% Delete old tiledlayout objects
oldTL = findall(app.TimeHistoryPanel, 'Type', 'tiledlayout');
delete(oldTL);

%% ------------------------------------------------------------------------
%  4. Create new tiledlayout
% -------------------------------------------------------------------------
tl = tiledlayout(app.TimeHistoryPanel, 3, 1, ...
    'TileSpacing', 'compact', ...
    'Padding', 'compact');

%% ------------------------------------------------------------------------
%  5. Plot Acceleration
% -------------------------------------------------------------------------
axA = nexttile(tl);

if showA
    if ~compareMode
        plot(axA, t, normalizeIfNeeded(app, app.curSignals.aF), 'k');
        title(axA, 'Acceleration');
    else
        plot(axA, t, normalizeIfNeeded(app, app.ASignals.aF), 'k', ...
                 t, normalizeIfNeeded(app, app.BSignals.aF), 'r');
        title(axA, 'Acceleration (A vs B)');
        legend(axA, {'A','B'});
    end
end
ylabel(axA, 'Accel');

%% ------------------------------------------------------------------------
%  6. Plot Velocity
% -------------------------------------------------------------------------
axV = nexttile(tl);

if showV
    if ~compareMode
        plot(axV, t, normalizeIfNeeded(app, app.curSignals.v), 'b');
        title(axV, 'Velocity');
    else
        plot(axV, t, normalizeIfNeeded(app, app.ASignals.v), 'b', ...
                 t, normalizeIfNeeded(app, app.BSignals.v), 'm');
        title(axV, 'Velocity (A vs B)');
        legend(axV, {'A','B'});
    end
end
ylabel(axV, 'Velocity');

%% ------------------------------------------------------------------------
%  7. Plot Displacement
% -------------------------------------------------------------------------
axD = nexttile(tl);

if showD
    if ~compareMode
        plot(axD, t, normalizeIfNeeded(app, app.curSignals.d), 'r');
        title(axD, 'Displacement');
    else
        plot(axD, t, normalizeIfNeeded(app, app.ASignals.d), 'r', ...
                 t, normalizeIfNeeded(app, app.BSignals.d), 'c');
        title(axD, 'Displacement (A vs B)');
        legend(axD, {'A','B'});
    end
end
ylabel(axD, 'Disp');
xlabel(axD, 'Time (s)');

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
        y = y ./ max(abs(y));
    end
end
