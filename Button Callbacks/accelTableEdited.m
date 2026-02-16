function accelTableEdited(app, evt)

    row = evt.Indices(1);
    col = evt.Indices(2);

    switch col
        case 3  % Axis changed
            newAxis = app.AccelTable.Data{row,3};
            app.AccelAxes{row} = newAxis;

        case 4  % Invert changed
            inv = app.AccelTable.Data{row,4};
            if inv
                app.AccelSignals{row} = -app.AccelSignals{row};
            end
    end

    handleAccelSelect(app, row);

end
