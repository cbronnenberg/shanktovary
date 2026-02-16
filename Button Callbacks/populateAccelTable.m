function populateAccelTable(app, accelNames)
% POPULATEACCELTABLE
% Populates the accelerometer table with names and default metadata.

    if isempty(app.AccelTable) || ~isvalid(app.AccelTable)
        return;
    end

    n = numel(accelNames);

    % Default columns: Name | Axis | Invert
    data = cell(n, 3);

    for i = 1:n
        data{i,1} = accelNames{i};   % Name
        data{i,2} = 'Z';             % Default axis
        data{i,3} = false;           % Default invert
    end

    app.AccelTable.Data = data;

end
