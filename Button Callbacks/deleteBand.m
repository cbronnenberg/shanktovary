function deleteBand(app)
    row = app.BandTable.Selection;

    if isempty(row)
        return;
    end

    data = app.BandTable.Data;
    data(row,:) = [];
    app.BandTable.Data = data;

    app.updateBandPlot();
end

% app.DeleteBandButton.ButtonPushedFcn = @(~,~) app.deleteBand();
