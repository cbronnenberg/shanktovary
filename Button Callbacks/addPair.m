function addPair(app)

    % Ensure lists exist
    if isempty(app.PairAList)
        app.PairAList = {};
    end
    if isempty(app.PairBList)
        app.PairBList = {};
    end

    % Get selected accelerometers
    sel = app.AccelTable.Selection;
    if numel(sel) ~= 2
        uialert(app.UIFigure, ...
            'Please select exactly two accelerometers to form a pair.', ...
            'Invalid Selection');
        return;
    end

    idxA = sel(1);
    idxB = sel(2);

    nameA = app.AccelNames{idxA};
    nameB = app.AccelNames{idxB};

    % Append to lists
    app.PairAList{end+1} = nameA;
    app.PairBList{end+1} = nameB;

    % Update table
    app.PairTable.Data = [app.PairAList(:), app.PairBList(:)];

end
