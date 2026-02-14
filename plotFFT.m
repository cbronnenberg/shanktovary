% --- FFTs (3 subplots) ---
axParent = app.AxFFT;
cla(axParent);

tiledlayout(axParent, 3, 1, 'TileSpacing','compact','Padding','compact');

% Accel FFT
nexttile(axParent);
loglog(fvec, abs(A), 'k');
xlim([1 2000]);
ylabel('|A(f)|');
title('Acceleration Spectrum');

% Velocity FFT
nexttile(axParent);
loglog(fvec, abs(V), 'b');
xlim([1 2000]);
ylabel('|V(f)|');
title('Velocity Spectrum');

% Displacement FFT
nexttile(axParent);
loglog(fvec, abs(D), 'r');
xlim([1 2000]);
ylabel('|D(f)|');
xlabel('Frequency (Hz)');
title('Displacement Spectrum');
