function sig = processSignal(app, rawAccel, t)
% PROCESSSIGNAL
% Converts raw accel to internal units, applies filtering, integrates to
% velocity and displacement, and returns a unified signal struct.
%
% Internal units = units that can be directly integrated (e.g., in/s^2).
% Display units  = original engineering units (e.g., g, m/s^2, etc.)

    %% ------------------------------------------------------------
    % 1. Convert accel to internal units (integrable)
    %% ------------------------------------------------------------
    aUS = convertAccelUnitsToInternal(app, rawAccel);
    % aUS is ALWAYS the unfiltered, internal-unit acceleration

    %% ------------------------------------------------------------
    % 2. Apply filtering (HP, LP, detrend, taper, etc.)
    %% ------------------------------------------------------------
    aF_US = filterAccel(app, aUS);
    % aF_US is filtered acceleration in internal units

    %% ------------------------------------------------------------
    % 3. Integrate to velocity (internal units)
    %% ------------------------------------------------------------
    v = integrateVelocity(app, aF_US, t);

    %% ------------------------------------------------------------
    % 4. Integrate to displacement (internal units)
    %% ------------------------------------------------------------
    d = integrateDisplacement(app, v, t);

    %% ------------------------------------------------------------
    % 5. Convert filtered accel back to original units for display
    %% ------------------------------------------------------------
    aDisplay = convertAccelUnitsInternalToOriginal(app, aF_US);

    %% ------------------------------------------------------------
    % 6. Package everything into a clean struct
    %% ------------------------------------------------------------
    sig = struct( ...
        'aUS', aUS, ...        % accel in internal units (unfiltered)
        'aF',  aDisplay, ...   % filtered accel in original units (display)
        'v',   v, ...          % velocity (internal units)
        'd',   d );            % displacement (internal units)

end
