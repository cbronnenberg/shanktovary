function BandsTableCellSelection(app, event)
    if isempty(event.Indices)
        return;
    end
    selectedRow = event.Indices(1);
    app.BandLimitedReconstruction(selectedRow);
end
