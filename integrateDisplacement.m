function d = integrateDisplacement(app, v, t)
%INTEGRATEDISPLACEMENT  Integrate velocity (internal units) to displacement.
%
%   v : velocity in internal units (in/s)
%   t : time vector (s)
%
%   d : displacement in internal units (in)

    % Ensure column vectors
    v = v(:);
    t = t(:);

    % Trapezoidal integration
    d = cumtrapz(t, v);

end
