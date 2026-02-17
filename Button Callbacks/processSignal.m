function sig = processSignal(app, rawAccel, t)
% PROCESSSIGNAL
% Converts raw accel to US units, applies filtering, integrates to velocity
% and displacement, and returns a unified signal struct.

    % ------------------------------------------------------------
    % 1. Convert accel to internal US units (in/s^2)
    % ------------------------------------------------------------
    aUS = convertAccelToInPerSec2(app, rawAccel);

    % ------------------------------------------------------------
    % 2. Apply filtering (HP, LP, detrend, taper, etc.)
    % ------------------------------------------------------------
    aF = filterAccel(app, aUS);

    % ------------------------------------------------------------
    % 3. Integrate to velocity
    % ------------------------------------------------------------
    v = integrateVelocity(app, aF, t);

    % ------------------------------------------------------------
    % 4. Integrate to displacement
    % ------------------------------------------------------------
    d = integrateDisplacement(app, v, t);

    % ------------------------------------------------------------
    % 5. Convert filtered accel back to original units for display
    % ------------------------------------------------------------
    aDisplay = convertAccelBackToOriginalUnits(app, aF);

    % ------------------------------------------------------------
    % 6. Package everything into a clean struct
    % ------------------------------------------------------------
    sig = struct( ...
        'aUS', aUS, ...        % accel in internal US units
        'aF',  aDisplay, ...   % filtered accel in original units
        'v',   v, ...          % velocity (in/s)
        'd',   d );            % displacement (in)

end
