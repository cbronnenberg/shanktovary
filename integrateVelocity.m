function v = integrateVelocity(app, aF_US, t)
%INTEGRATEVELOCITY  Integrate acceleration (internal units) to velocity.
%
%   aF_US : filtered acceleration in internal units (in/s^2)
%   t     : time vector (s)
%
%   v     : velocity in internal units (in/s)

    % Ensure column vectors
    aF_US = aF_US(:);
    t     = t(:);

    % Trapezoidal integration
    v = cumtrapz(t, aF_US);

end
