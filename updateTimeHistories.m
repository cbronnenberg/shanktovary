function updateTimeHistories(app)

    parent = app.TimePanel;
    delete(parent.Children);

    tl = tiledlayout(parent,3,1,'TileSpacing','compact','Padding','compact');

    showA = app.ShowAccelCheckBox.Value;
    showV = app.ShowVelocityCheckBox.Value;
    showD = app.ShowDisplacementCheckBox.Value;

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

    linkaxes([axA axV axD],'x');
    enableDefaultInteractivity(axA);
    enableDefaultInteractivity(axV);
    enableDefaultInteractivity(axD);

end
