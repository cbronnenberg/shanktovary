function updatePSDPlot(app)

    if ~isvalid(app) || isempty(app.PSDPanel) || ~isvalid(app.PSDPanel)
        return;
    end

    parent = app.PSDPanel;

    % Clear graphics
    kids = parent.Children;
    for k = 1:numel(kids)
        if isa(kids(k),'matlab.graphics.Graphics') || isa(kids(k),'matlab.graphics.layout.TiledChartLayout')
            delete(kids(k));
        end
    end

    tl = tiledlayout(parent,3,2);
    tl.Padding = 'compact';
    tl.TileSpacing = 'compact';

    t = app.t;
    fs = 1/mean(diff(t));

    sigA = app.curSignals.aF;
    sigV = app.curSignals.v;
    sigD = app.curSignals.d;

    p = app.getFFTParams();
    window   = p.Window;
    overlap  = p.OverlapLength;
    nfft     = p.Nfft;

    % Helper
    function [f,P,cRMS] = computePSD(x)
        [P,f] = pwelch(x, window, overlap, nfft, fs);
        df = f(2)-f(1);
        cRMS = sqrt(cumsum(P)*df);
    end

    % --- Accel PSD ---
    [fA,PA,cA] = computePSD(sigA);
    ax = nexttile(tl);
    plot(ax, fA, PA);
    app.applyPlotStyle(ax, 'Accel PSD', 'Frequency (Hz)', 'PSD', {'Accel'});

    ax = nexttile(tl);
    plot(ax, fA, cA);
    app.applyPlotStyle(ax, 'Accel Cumulative RMS', 'Frequency (Hz)', 'RMS', {'Accel'});

    % --- Velocity PSD ---
    [fV,PV,cV] = computePSD(sigV);
    ax = nexttile(tl);
    plot(ax, fV, PV);
    app.applyPlotStyle(ax, 'Velocity PSD', 'Frequency (Hz)', 'PSD', {'Velocity'});

    ax = nexttile(tl);
    plot(ax, fV, cV);
    app.applyPlotStyle(ax, 'Velocity Cumulative RMS', 'Frequency (Hz)', 'RMS', {'Velocity'});

    % --- Displacement PSD ---
    [fD,PD,cD] = computePSD(sigD);
    ax = nexttile(tl);
    plot(ax, fD, PD);
    app.applyPlotStyle(ax, 'Displacement PSD', 'Frequency (Hz)', 'PSD', {'Displacement'});

    ax = nexttile(tl);
    plot(ax, fD, cD);
    app.applyPlotStyle(ax, 'Displacement Cumulative RMS', 'Frequency (Hz)', 'RMS', {'Displacement'});

end

function updatePSDPlot2(app)
%UPDATEPSDPLOT  Refresh the PSD plot.

%% Startup guards
if isempty(app) || ~isvalid(app)
    return
end
if isempty(app.PSDPanel) || ~isvalid(app.PSDPanel)
    return
end
if isempty(app.curSignals) || isempty(app.curSignals.aF)
    return
end

%% Read UI state
compareMode = app.CompareFiltersCheckBox.Value && ...
              ~isempty(app.ASignals) && ~isempty(app.BSignals);

%% Clear only axes/tiledlayouts
delete(findall(app.PSDPanel, 'Type', 'axes'));
delete(findall(app.PSDPanel, 'Type', 'tiledlayout'));

%% Create layout
tl = tiledlayout(app.PSDPanel, 1, 1, ...
    'TileSpacing', 'compact', ...
    'Padding', 'compact');

ax = nexttile(tl);

%% Compute PSD
fs = app.SampleRate;

if ~compareMode
    [pxx,f] = pwelch(app.curSignals.aF, [], [], [], fs);
    plot(ax, f, 10*log10(pxx), 'k');
    title(ax, 'PSD');
else
    [pxxA,fA] = pwelch(app.ASignals.aF, [], [], [], fs);
    [pxxB,fB] = pwelch(app.BSignals.aF, [], [], [], fs);
    plot(ax, fA, 10*log10(pxxA), 'k', ...
             fB, 10*log10(pxxB), 'r');
    legend(ax, {'A','B'});
    title(ax, 'PSD (A vs B)');
end

xlabel(ax, 'Frequency (Hz)');
ylabel(ax, 'Power/Frequency (dB/Hz)');
grid(ax, 'on');
enableDefaultInteractivity(ax);

end
