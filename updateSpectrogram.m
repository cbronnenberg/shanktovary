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
