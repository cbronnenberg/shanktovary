
properties (Access = public)
    a
    fs
    t

    FilterA
    FilterB
end


function y = normalizeSignal(app, x)
    if app.NormalizeCheckBox.Value
        y = x ./ max(abs(x));
    else
        y = x;
    end
end


function applyFFTScale(app, ax)
    switch app.FFTScaleDropDown.Value
        case 'Log'
            ax.XScale = 'log';
            ax.YScale = 'log';
        case 'Linear'
            ax.XScale = 'linear';
            ax.YScale = 'linear';
    end
end


function y = applyFilters(app, x, filt)
    dHP = designfilt('highpassiir','FilterOrder',filt.order,...
        'HalfPowerFrequency',filt.hp,'SampleRate',app.fs);
    dLP = designfilt('lowpassiir','FilterOrder',filt.order,...
        'HalfPowerFrequency',filt.lp,'SampleRate',app.fs);
    y = filtfilt(dHP, filtfilt(dLP, x));
end


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


