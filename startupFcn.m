%% startupFcn.m

function startupFcn(app, accel, fs)
    % Core data
    app.a  = accel(:);
    app.fs = fs;
    app.t  = (0:length(accel)-1)'/fs;

    % Default control values (optional, but explicit)
    app.HPField.Value    = 10;
    app.LPField.Value    = 2000;
    app.OrderField.Value = 6;

    % Default bands
    app.BandTable.Data = [5 10; 10 20; 20 50; 50 200; 200 2000];

    % Initialize axes appearance
    initAxes(app);
end
