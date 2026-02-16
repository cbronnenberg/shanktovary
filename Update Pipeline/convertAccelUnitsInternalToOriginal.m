function a_out = convertAccelUnitsInternalToOriginal(app, a)

    switch lower(app.InputAccelUnits)
        case 'g'
            a_out = a / 386.088582677;

        case 'm/s^2'
            a_out = a / 39.37007874;

        case 'in/s^2'
            a_out = a;

        otherwise
            a_out = a;
    end
end
