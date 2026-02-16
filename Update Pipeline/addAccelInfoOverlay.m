function addAccelInfoOverlay(app, ax)

    if isempty(app.AccelNames)
        return;
    end

    sel = app.AccelTable.Selection;
    if isempty(sel)
        return;
    end

    idx = sel(1);
    name = app.AccelNames{idx};

    % Example metadata (replace with real fields)
    sens = app.SensitivityField.Value;
    units = app.UnitsField.Value;
    notes = app.AccelNotesField.Value;

    txt = sprintf('%s\nSensitivity: %s\nUnits: %s\n%s', ...
        name, num2str(sens), units, notes);

    % Place in upper-left corner
    annotation(ax.Parent, 'textbox', ...
        'String', txt, ...
        'FitBoxToText','on', ...
        'BackgroundColor',[1 1 1 0.7], ...
        'EdgeColor','none', ...
        'Position',[0.02 0.75 0.2 0.2], ...
        'Interpreter','none');
end
