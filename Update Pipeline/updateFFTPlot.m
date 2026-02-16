function updateFFTPlot(app)

    if ~isvalid(app) || isempty(app.FFTPanel) || ~isvalid(app.FFTPanel)
        return;
    end

    parent = app.FFTPanel;

    % Delete graphics children only
    kids = parent.Children;
    for k = 1:numel(kids)
        if isa(kids(k),'matlab.graphics.Graphics') || isa(kids(k),'matlab.graphics.layout.TiledChartLayout')
            delete(kids(k));
        end
    end

    tl = tiledlayout(parent,1,1);
    tl.Padding = 'compact';
    tl.TileSpacing = 'compact';

    nexttile(tl);
    hold on;

    t = app.t;
    fs = 1/mean(diff(t));

    % FFT of current signal
    aF = app.curSignals.aF;
    N = numel(aF);
    f = (0:N-1)*(fs/N);
    A = abs(fft(aF));

    plot(f, A, 'b', 'LineWidth',1.1);

    % A/B compare
    if app.CompareFiltersCheckBox.Value && ~isempty(app.ASignals) && ~isempty(app.BSignals)
        A_A = abs(fft(app.ASignals.aF));
        A_B = abs(fft(app.BSignals.aF));
        plot(f, A_A, 'r', 'LineWidth',1.1);
        plot(f, A_B, 'g', 'LineWidth',1.1);
    end

    xlim([0 fs/2]);
    xlabel('Frequency (Hz)');
    ylabel('|FFT|');
    title('FFT Magnitude');
    grid on;

end
