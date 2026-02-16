function applyPlotStyle(app, ax, titleStr, xlab, ylab, legendEntries)

    % --- Apply scale ---
    switch app.PlotScale
        case 'Linear'
            set(ax, 'XScale','linear', 'YScale','linear');
        case 'Log'
            set(ax, 'XScale','log', 'YScale','log');
        case 'SemilogX'
            set(ax, 'XScale','log', 'YScale','linear');
        case 'SemilogY'
            set(ax, 'XScale','linear', 'YScale','log');
    end

    % --- Titles and labels ---
    title(ax, titleStr, 'FontWeight','bold');
    xlabel(ax, xlab);
    ylabel(ax, ylab);

    % --- Legend ---
    if nargin >= 6 && ~isempty(legendEntries)
        legend(ax, legendEntries, 'Location','best');
    end

    % --- Grid ---
    grid(ax, 'on');

    % --- Add metadata overlay ---
    app.addAccelInfoOverlay(ax);

end
