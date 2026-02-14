function dB = bandLimitedDisp(app, a, fs, t, f1, f2)

    % Bandpass filter
    d = designfilt('bandpassiir','FilterOrder',6,...
        'HalfPowerFrequency1',f1,...
        'HalfPowerFrequency2',f2,...
        'SampleRate',fs);

    aB = filtfilt(d, a);

    % First integration
    vB = cumtrapz(t, aB);

    % Optional filtering between integrations
    if app.FilterBetweenIntegrationsCheckBox.Value
        hp = app.HPField.Value;
        dHP = designfilt('highpassiir','FilterOrder',6,...
            'HalfPowerFrequency',hp,'SampleRate',fs);
        vB = filtfilt(dHP, vB);
    end

    % Second integration
    dB = cumtrapz(t, vB);
end
