function populateAccelTable(app, accelNames, accelAxes)

    n = numel(accelNames);
    data = cell(n, 4);

    for i = 1:n
        data{i,1} = false;          % Select checkbox
        data{i,2} = accelNames{i};  % Name
        data{i,3} = accelAxes{i};   % Axis
        data{i,4} = false;          % Invert
    end

    app.AccelTable.Data = data;

end
