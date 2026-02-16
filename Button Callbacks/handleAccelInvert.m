function handleAccelInvert(app, row)

    invert = app.AccelTable.Data{row,4};

    % Modify the stored signal
    sig = app.AccelSignals{row};

    if invert
        sig = -sig;
    end

    app.AccelSignals{row} = sig;

    % If this row is selected, update curSignals
    if app.AccelTable.Data{row,1}
        app.setCurrentSignalFromIndex(row);
    end

end
