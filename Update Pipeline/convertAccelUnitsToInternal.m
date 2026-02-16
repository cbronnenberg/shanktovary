function a_out = convertAccelUnitsToInternal(app, a)

    switch lower(app.InputAccelUnits)
        case 'g'
            a_out = a * 386.088582677;   % 1 g = 386.0886 in/s^2

        case 'm/s^2'
            a_out = a * 39.37007874;     % 1 m/s^2 = 39.37 in/s^2

        case 'in/s^2'
            a_out = a;

        otherwise
            warning('Unknown accel units. Assuming in/s^2.');
            a_out = a;
    end
end
