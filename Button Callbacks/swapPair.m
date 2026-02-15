function swapPair(app)
    row = app.PairTable.Selection;

    if isempty(row)
        return;
    end

    data = app.PairTable.Data;
    temp = data{row,1};
    data{row,1} = data{row,2};
    data{row,2} = temp;

    app.PairTable.Data = data;

    % Recompute
    app.computeRelativeDisplacement();
    app.updateBandPlot();
    app.updatePSDPlot();
end

% app.SwapPairButton.ButtonPushedFcn = @(~,~) app.swapPair();
