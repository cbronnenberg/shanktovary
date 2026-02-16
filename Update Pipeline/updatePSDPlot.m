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

    % Helper for PSD
    function [f,P] = psd(x)
        [P,f] = pwelch(x, hamming(2048), 1024, 2048, fs);
    end

    % Accel PSD
    [fA,PA] = psd(sigA);
    nexttile(tl); plot(fA, PA); grid on; title('Accel PSD');
    nexttile(tl); plot(fA, cumsum(PA)); grid on; title('Accel Cum RMS');

    % Vel PSD
    [fV,PV] = psd(sigV);
    nexttile(tl); plot(fV, PV); grid on; title('Vel PSD');
    nexttile(tl); plot(fV, cumsum(PV)); grid on; title('Vel Cum RMS');

    % Disp PSD
    [fD,PD] = psd(sigD);
    nexttile(tl); plot(fD, PD); grid on; title('Disp PSD');
    nexttile(tl); plot(fD, cumsum(PD)); grid on; title('Disp Cum RMS');

end
