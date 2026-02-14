function BandLimitedReconstruction(app, selectedRow)

    % Safety checks
    if isempty(app.BandLineHandles) || selectedRow < 1 ...
            || selectedRow > size(app.BandLineHandles,1)
        return;
    end

    ax = app.BandAxesHandle;
    if ~isgraphics(ax)
        return;
    end

    % Reset all lines
    for k = 1:size(app.BandLineHandles,1)
        for j = 1:size(app.BandLineHandles,2)
            h = app.BandLineHandles(k,j);
            if isgraphics(h)
                h.LineWidth = 1.1;
                h.Color = h.Color * 0.8 + 0.2*[1 1 1]; % soften
            end
        end
    end

    % Highlight selected band
    for j = 1:size(app.BandLineHandles,2)
        h = app.BandLineHandles(selectedRow,j);
        if isgraphics(h)
            h.LineWidth = 3;
            h.Color = [0 0 0]; % bold highlight
        end
    end

    % Optional: zoom to selected band
    allY = [];
    for j = 1:size(app.BandLineHandles,2)
        h = app.BandLineHandles(selectedRow,j);
        if isgraphics(h)
            allY = [allY; h.YData(:)];
        end
    end

    if ~isempty(allY)
        pad = 0.1 * range(allY);
        ylim(ax, [min(allY)-pad, max(allY)+pad]);
    end
end
