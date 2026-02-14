function y = normalizeSignal(app, x)
    if app.NormalizeCheckBox.Value
        m = max(abs(x));
        if m > 0
            y = x ./ m;
        else
            y = x;
        end
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

    d = designfilt('bandpassiir','FilterOrder',6,...
        'HalfPowerFrequency1',f1,...
        'HalfPowerFrequency2',f2,...
        'SampleRate',fs);

    aB = filtfilt(d, a);

    vB = cumtrapz(t, aB);

    if app.FilterBetweenIntegrationsCheckBox.Value
        hp = app.HPField.Value;
        dHP = designfilt('highpassiir','FilterOrder',6,...
            'HalfPowerFrequency',hp,'SampleRate',fs);
        vB = filtfilt(dHP, vB);
    end

    dB = cumtrapz(t, vB);
end

function out = exportCurrentResults(app)
    out = struct();
    out.fs = app.fs;
    out.t  = app.t;
    out.a  = app.a;

    out.cur = app.curSignals;
    out.A   = app.ASignals;
    out.B   = app.BSignals;

    out.bands = app.DominantBandsTable;
end

function X = fdIntegrate(app, F, fvec, order)
    w = 2*pi*fvec;
    w(1) = NaN; % avoid DC
    H = (1./(1i*w)).^order;
    X = F .* H;
end

