function removePair(app)

    sel = app.PairTable.Selection;
    if isempty(sel)
        return;
    end

    row = sel(1);

    app.PairAList(row) = [];
    app.PairBList(row) = [];

    app.PairTable.Data = [app.PairAList(:), app.PairBList(:)];

end
