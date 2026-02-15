function addBand(app)
    f1 = app.BandStartField.Value;
    f2 = app.BandEndField.Value;

    newRow = {f1, f2};
    app.BandTable.Data = [app.BandTable.Data; newRow];

    app.updateBandPlot();
end

% app.AddBandButton.ButtonPushedFcn = @(~,~) app.addBand();
