function updateSpectrogramTab(app, S)

    parent = app.SpectrogramPanel;
    delete(parent.Children);

    ax = axes(parent);

    imagesc(ax, S.t, S.f, 20*log10(abs(S.s)));
    axis(ax,'xy');
    colormap(ax,'jet');
    colorbar(ax);
    xlabel(ax,'Time (s)');
    ylabel(ax,'Frequency (Hz)');
    title(ax,'Spectrogram (dB)');
    grid(ax,'on');

    app.annotateMetadata(ax);

    app.axSpec = ax;
end
