function addPair(app)
    % Read selected accelerometers
    a = app.PairAList.Value;
    b = app.PairBList.Value;

    % Add to table
    newRow = {a, b};
    app.PairTable.Data = [app.PairTable.Data; newRow];

    % Compute relative displacement
    app.computeRelativeDisplacement();

    % Update dependent plots
    app.updateBandPlot();
    app.updatePSDPlot();
end
