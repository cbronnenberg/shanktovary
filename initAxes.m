%% initAxes.m
methods (Access = private)

    function initAxes(app)
        % Spectrogram
        app.AxSpectrogram.Title.String = 'Acceleration Spectrogram';
        app.AxSpectrogram.XLabel.String = 'Time (s)';
        app.AxSpectrogram.YLabel.String = 'Frequency (Hz)';

        % FFT
        app.AxFFT.Title.String = 'Spectral Growth Through Integration';
        app.AxFFT.XLabel.String = 'Frequency (Hz)';
        app.AxFFT.YLabel.String = 'Magnitude';
        app.AxFFT.XScale = 'log';
        app.AxFFT.YScale = 'log';

        % Time histories
        app.AxTime.Title.String = 'Time Histories';
        app.AxTime.XLabel.String = 'Time (s)';
        app.AxTime.YLabel.String = 'Amplitude';

        % Band-limited
        app.AxBands.Title.String = 'Band-Limited Displacement Contributions';
        app.AxBands.XLabel.String = 'Time (s)';
        app.AxBands.YLabel.String = 'Offset Displacement';
    end

end
