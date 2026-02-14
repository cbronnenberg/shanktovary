function annotatePeaks(app, ax, fvec, mag, nPeaks)
    [pks, locs] = findpeaks(mag, fvec, 'SortStr','descend');
    nPeaks = min(nPeaks, numel(pks));
    if nPeaks < 1, return; end

    fSel = locs(1:nPeaks);
    pSel = pks(1:nPeaks);

    hold(ax,'on');
    plot(ax, fSel, pSel, 'o', 'MarkerFaceColor','r', 'MarkerEdgeColor','k');
    for i = 1:nPeaks
        text(ax, fSel(i), pSel(i), sprintf(' %.1f Hz', fSel(i)), ...
            'VerticalAlignment','bottom','Color','k');
    end
    hold(ax,'off');
end
