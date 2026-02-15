function annotateMetadata(app, ax)
    % Clear previous annotation in this axes (optional)
    % delete(findall(ax,'Tag','MetaText'));

    lines = {};

    % Mode
    lines{end+1} = sprintf('Mode: %s', app.ProcessingMode);

    % Units
    lines{end+1} = sprintf('Units: %s', app.AccelUnitsDropDown.Value);

    % FFT
    Nfft = app.FFTSizeDropDown.Value;
    fs   = app.fs;
    BW   = fs / Nfft;
    lines{end+1} = sprintf('FFT: %d (BW=%.3g Hz)', Nfft, BW);

    % Window / overlap
    lines{end+1} = sprintf('Win: %.0f%%, Ovl: %.0f%%', ...
        app.WindowPercentField.Value, app.OverlapPercentField.Value);

    % Filter info (assuming you have HP/LP/order fields)
    lines{end+1} = sprintf('HP: %.3g Hz, LP: %.3g Hz, Ord: %d', ...
        app.HPField.Value, app.LPField.Value, app.FilterOrderField.Value);

    % Bands summary (if any)
    if ~isempty(app.BandTable.Data)
        names = app.BandTable.Data.Name;
        lines{end+1} = sprintf('Bands: %s', strjoin(names, ', '));
    end

    % Relative pair info (if in relative mode)
    if app.ProcessingMode == "Relative" && isfield(app,'CurrentPair')
        lines{end+1} = sprintf('Pair: %s - %s', ...
            app.CurrentPair.Name1, app.CurrentPair.Name2);
    end

    txt = strjoin(lines, '\n');

    t = annotation(ax.Parent,'textbox', ...
        'String',txt, ...
        'FitBoxToText','on', ...
        'BackgroundColor',[1 1 1 0.7], ...
        'EdgeColor','none', ...
        'Units','normalized', ...
        'Position',[0.01 0.98 0.3 0.1], ...
        'HorizontalAlignment','left', ...
        'VerticalAlignment','top');

    t.Tag = 'MetaText';
end
