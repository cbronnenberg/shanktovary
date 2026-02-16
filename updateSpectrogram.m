function updateSpectrogram(app)

    parent = app.SpectrogramPanel;
    delete(parent.Children);

    compareMode = app.CompareFiltersCheckBox.Value && ...
                  ~isempty(app.ASignals) && ~isempty(app.BSignals);

    if ~compareMode
        % Normal mode
        tl = tiledlayout(parent,1,1,'TileSpacing','compact','Padding','compact');
        ax = nexttile(tl);

        aF = app.curSignals.aF;
        spectrogram(aF, 1024, 768, app.curSignals.Nfft, app.fs, 'yaxis');
        title(ax,'Spectrogram (Current Filter)');
        ylabel(ax,'Frequency (Hz)');
        xlabel(ax,'Time (s)');
        colormap(ax,'parula');

    else
        % Compare mode: A (top), B (bottom)
        tl = tiledlayout(parent,2,1,'TileSpacing','compact','Padding','compact');

        ax1 = nexttile(tl);
        spectrogram(app.ASignals.aF, 1024, 768, app.curSignals.Nfft, app.fs, 'yaxis');
        title(ax1,'Spectrogram - Filter A');
        ylabel(ax1,'Frequency (Hz)');
        colormap(ax1,'parula');

        ax2 = nexttile(tl);
        spectrogram(app.BSignals.aF, 1024, 768, app.curSignals.Nfft, app.fs, 'yaxis');
        title(ax2,'Spectrogram - Filter B');
        ylabel(ax2,'Frequency (Hz)');
        xlabel(ax2,'Time (s)');
        colormap(ax2,'parula');

        linkaxes([ax1 ax2],'x');
    end
end

function updateSpectrogramPlot2(app)
%UPDATESPECTROGRAMPLOT  Refresh the spectrogram plot.

%% Startup guards
if isempty(app) || ~isvalid(app)
    return
end
if isempty(app.SpectrogramPanel) || ~isvalid(app.SpectrogramPanel)
    return
end
if isempty(app.curSignals) || isempty(app.curSignals.aF)
    return
end

%% Clear only axes/tiledlayouts
delete(findall(app.SpectrogramPanel, 'Type', 'axes'));
delete(findall(app.SpectrogramPanel, 'Type', 'tiledlayout'));

%% Create layout
tl = tiledlayout(app.SpectrogramPanel, 1, 1, ...
    'TileSpacing', 'compact', ...
    'Padding', 'compact');

ax = nexttile(tl);

%% Compute spectrogram
x = app.curSignals.aF;
fs = app.SampleRate;

window = hann(512);
noverlap = 256;
nfft = 1024;

[s,f,t] = spectrogram(x, window, noverlap, nfft, fs);

%% Plot
imagesc(ax, t, f, 20*log10(abs(s)));
axis(ax, 'xy');
colormap(ax, jet);
colorbar(ax);

xlabel(ax, 'Time (s)');
ylabel(ax, 'Frequency (Hz)');
title(ax, 'Spectrogram');

end
