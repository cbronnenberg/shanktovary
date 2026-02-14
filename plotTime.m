% --- Time Histories (3 subplots) ---
axParent = app.AxTime;
cla(axParent);

% Create a tiled layout inside the UIAxes
tiledlayout(axParent, 3, 1, 'TileSpacing','compact','Padding','compact');

% Acceleration
nexttile(axParent);
plot(t, aF, 'k');
ylabel('Accel');
title('Acceleration');

% Velocity
nexttile(axParent);
plot(t, v, 'b');
ylabel('Velocity');
title('Velocity');

% Displacement
nexttile(axParent);
plot(t, d, 'r');
ylabel('Disp');
xlabel('Time (s)');
title('Displacement');
