function updateTimePlot(app)
    % Clear previous content
    delete(app.TimePanel.Children);

    % If no data loaded, exit gracefully
    if isempty(app.SegTimeVector) || isempty(app.SegSignals)
        return;
    end

    % Create a 3-row tiled layout
    tl = tiledlayout(app.TimePanel, 3, 1, ...
        'Padding', 'compact', ...
        'TileSpacing', 'compact');

    % --- ACCELERATION ---
    ax1 = nexttile(tl);
    hold(ax1, 'on');
    for k = 1:numel(app.SegSignals)
        plot(ax1, app.SegTimeVector, app.SegSignals{k}, 'LineWidth', 1.0);
    end
    hold(ax1, 'off');
    ylabel(ax1, 'Accel (g)');
    title(ax1, 'Acceleration Time History');

    % --- VELOCITY ---
    ax2 = nexttile(tl);
    hold(ax2, 'on');
    for k = 1:numel(app.SegSignals)
        vel = cumtrapz(app.SegTimeVector, app.SegSignals{k});
        plot(ax2, app.SegTimeVector, vel, 'LineWidth', 1.0);
    end
    hold(ax2, 'off');
    ylabel(ax2, 'Velocity (in/s)');
    title(ax2, 'Velocity Time History');

    % --- DISPLACEMENT ---
    ax3 = nexttile(tl);
    hold(ax3, 'on');
    for k = 1:numel(app.SegSignals)
        vel = cumtrapz(app.SegTimeVector, app.SegSignals{k});
        disp = cumtrapz(app.SegTimeVector, vel);
        plot(ax3, app.SegTimeVector, disp, 'LineWidth', 1.0);
    end
    hold(ax3, 'off');
    ylabel(ax3, 'Displacement (mil)');
    xlabel(ax3, 'Time (s)');
    title(ax3, 'Displacement Time History');

    % Link x-axes
    linkaxes([ax1 ax2 ax3], 'x');

    % Store handles
    app.TimeAxes.Accel = ax1;
    app.TimeAxes.Vel   = ax2;
    app.TimeAxes.Disp  = ax3;
end
