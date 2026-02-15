function updateTimeHistories(app)

    parent = app.TimePanel;
    delete(parent.Children);

    % Create tiled layout
    tl = tiledlayout(parent,3,1,'TileSpacing','compact','Padding','compact');

    % Toggles
    showA = app.ShowAccelCheckBox.Value;
    showV = app.ShowVelocityCheckBox.Value;
    showD = app.ShowDisplacementCheckBox.Value;

    % Compare mode
    compareMode = app.CompareFiltersCheckBox.Value && ...
                  ~isempty(app.ASignals) && ~isempty(app.BSignals);

    t = app.t;

    % ---------------- Acceleration ----------------
    axA = nexttile(tl);
    if showA
        if ~compareMode
            plot(axA, t, app.normalizeSignal(app.curSignals.aF), 'k');
            title(axA,'Acceleration');
        else
            plot(axA, t, app.normalizeSignal(app.ASignals.aF), 'k', ...
                     t, app.normalizeSignal(app.BSignals.aF), 'r');
            title(axA,'Acceleration (A vs B)');
            legend(axA,{'A','B'});
        end
    end
    ylabel(axA,'Accel');

    % ---------------- Velocity ----------------
    axV = nexttile(tl);
    if showV
        if ~compareMode
            plot(axV, t, app.normalizeSignal(app.curSignals.v), 'b');
            title(axV,'Velocity');
        else
            plot(axV, t, app.normalizeSignal(app.ASignals.v), 'b', ...
                     t, app.normalizeSignal(app.BSignals.v), 'm');
            title(axV,'Velocity (A vs B)');
            legend(axV,{'A','B'});
        end
    end
    ylabel(axV,'Velocity');

    % ---------------- Displacement ----------------
    axD = nexttile(tl);
    if showD
        if ~compareMode
            plot(axD, t, app.normalizeSignal(app.curSignals.d), 'r');
            title(axD,'Displacement');
        else
            plot(axD, t, app.normalizeSignal(app.ASignals.d), 'r', ...
                     t, app.normalizeSignal(app.BSignals.d), 'c');
            title(axD,'Displacement (A vs B)');
            legend(axD,{'A','B'});
        end
    end
    ylabel(axD,'Disp');
    xlabel(axD,'Time (s)');

    % Link axes
    linkaxes([axA axV axD],'x');

    % Enable zoom/pan/cursor interactivity
    enableDefaultInteractivity(axA);
    enableDefaultInteractivity(axV);
    enableDefaultInteractivity(axD);

    % Store handles for cursor readouts, etc.
    app.TimeAxes.Accel = axA;
    app.TimeAxes.Vel   = axV;
    app.TimeAxes.Disp  = axD;

end
