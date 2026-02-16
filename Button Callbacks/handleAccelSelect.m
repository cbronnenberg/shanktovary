function handleAccelSelect(app, row)

    data = app.AccelTable.Data;

    % If user selects a new row, unselect all others
    for k = 1:size(data,1)
        data{k,1} = (k == row);
    end

    app.AccelTable.Data = data;

    % Update current signal
    app.setCurrentSignalFromIndex(row);

end
