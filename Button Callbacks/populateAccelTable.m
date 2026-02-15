function populateAccelTable(app, accelList)

    n = numel(accelList);

    % Default table values
    selectCol = num2cell(false(n,1));
    axisCol   = repmat({'Z'}, n, 1);
    invertCol = num2cell(false(n,1));

    app.AccelTable.Data = [selectCol, accelList(:), axisCol, invertCol];

end
