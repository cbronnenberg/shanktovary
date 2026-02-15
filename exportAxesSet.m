function exportAxesSet(app, axesList, fileNames)
    % axesList: cell array of axes handles
    % fileNames: cell array of full filenames (same length)

    f = figure('Visible','off','Color','w','Units','inches');
    f.Position(3:4) = [17 11];

    n = numel(axesList);
    rows = ceil(n/2);
    cols = min(2,n);

    tl = tiledlayout(f, rows, cols, ...
        'TileSpacing','compact', ...
        'Padding','compact');

    for k = 1:n
        axNew = nexttile(tl, k);
        src = axesList{k};

        copyobj(src.Children, axNew);
        title(axNew, src.Title.String);
        xlabel(axNew, src.XLabel.String);
        ylabel(axNew, src.YLabel.String);

        % copy limits, scales, grid
        axNew.XScale = src.XScale;
        axNew.YScale = src.YScale;
        xlim(axNew, xlim(src));
        ylim(axNew, ylim(src));
        grid(axNew, src.XGrid);

        exportgraphics(axNew, fileNames{k}, 'Resolution',300);
    end

    close(f);
end
