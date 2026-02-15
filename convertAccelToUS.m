function aSI = convertAccelToUS(app, a)
    switch app.AccelUnitsDropDown.Value
        case 'g'
            aUS = a;
        case 'in/s^2'
            aUS = 386.0866 * a;
        case 'm/s^2'
            aUS = a * 9.80665;
            
    end
end
