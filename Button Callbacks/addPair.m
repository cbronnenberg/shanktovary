function addPair(app)
    % This button:
% Adds a new row to the pairs table
% Computes relative displacement
% Updates Band‑Limited and PSD plots
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

% app.AddPairButton.ButtonPushedFcn = @(~,~) app.addPair();
% 