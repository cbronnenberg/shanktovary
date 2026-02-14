function UpdateButtonPushed(app, event)

    hp = app.HPField.Value;
    lp = app.LPField.Value;
    ord = app.OrderField.Value;
    bands = app.BandTable.Data;

    fs = app.fs;
    t = app.t;
    a = app.a;

    % Filtering
    dHP = designfilt('highpassiir','FilterOrder',ord,...
        'HalfPowerFrequency',hp,'SampleRate',fs);

    dLP = designfilt('lowpassiir','FilterOrder',ord,...
        'HalfPowerFrequency',lp,'SampleRate',fs);

    aF = filtfilt(dHP, filtfilt(dLP, a));

    % Integrations
    v = cumtrapz(t, aF);
    d = cumtrapz(t, v);

    % Spectrogram
    ax = app.AxSpectrogram;
    cla(ax);
    spectrogram(aF, 2048, 1024, 4096, fs, 'yaxis','Parent',ax);
    title(ax,'Acceleration Spectrogram');

    % FFTs
    N = length(a);
    fvec = (0:N-1)'*(fs/N);

    A = fft(aF);
    V = fft(v);
    D = fft(d);

    ax = app.AxFFT;
    cla(ax);
    loglog(ax, fvec, abs(A),'k'); hold(ax,'on');
    loglog(ax, fvec, abs(V),'b');
    loglog(ax, fvec, abs(D),'r');
    xlim(ax,[1 2000]);
    legend(ax,{'Accel','Vel','Disp'});
    title(ax,'Spectral Growth Through Integration');

    % Time Histories
    ax = app.AxTime;
    cla(ax);
    plot(ax, t, aF,'k'); hold(ax,'on');
    plot(ax, t, v,'b');
    plot(ax, t, d,'r');
    legend(ax,{'Accel','Vel','Disp'});
    title(ax,'Time Histories');

    % Band-Limited Reconstructions
    ax = app.AxBands;
    cla(ax);
    hold(ax,'on');

    for k = 1:size(bands,1)
        f1 = bands(k,1);
        f2 = bands(k,2);

        dB = app.bandLimitedDisp(aF, fs, t, f1, f2);

        offset = (k-1) * max(abs(dB)) * 2;
        plot(ax, t, dB + offset,'LineWidth',1.1);
    end

    title(ax,'Band-Limited Displacement Contributions');
    hold(ax,'off');

end
