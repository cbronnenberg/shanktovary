
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


% --- Button pushed function: UpdateButton
function UpdateButtonPushed(app, event)

    % Basic data
    a  = app.a(:);
    fs = app.fs;
    t  = app.t(:);

    % Current filter definition
    curFilt.hp    = app.HPField.Value;
    curFilt.lp    = app.LPField.Value;
    curFilt.order = app.OrderField.Value;

    % FFT length
    Nfft = round(app.NfftField.Value);
    if Nfft <= 0
        Nfft = 8192;
    end

    % Determine mode
    compareMode = app.CompareFiltersCheckBox.Value && ...
                  ~isempty(app.FilterA) && ~isempty(app.FilterB);

    % ---------------------------------------------------------------------
    % 1) Compute signals for current / A / B
    % ---------------------------------------------------------------------
    if ~compareMode
        % Normal mode: only current filter
        aF = app.applyFilters(a, curFilt);
        v  = cumtrapz(t, aF);
        d  = cumtrapz(t, v);

        % FFTs
        A = fft(aF, Nfft);
        V = fft(v,  Nfft);
        D = fft(d,  Nfft);

    else
        % Compare mode: use FilterA and FilterB
        fA = app.FilterA;
        fB = app.FilterB;

        % A
        aA = app.applyFilters(a, fA);
        vA = cumtrapz(t, aA);
        dA = cumtrapz(t, vA);

        % B
        aB = app.applyFilters(a, fB);
        vB = cumtrapz(t, aB);
        dB = cumtrapz(t, vB);

        % FFTs
        A_A = fft(aA, Nfft);
        V_A = fft(vA, Nfft);
        D_A = fft(dA, Nfft);

        A_B = fft(aB, Nfft);
        V_B = fft(vB, Nfft);
        D_B = fft(dB, Nfft);
    end

    fvec = (0:Nfft-1)' * (fs/Nfft);

    % ---------------------------------------------------------------------
    % 2) Spectrogram tab
    % ---------------------------------------------------------------------
    axSpec = app.SpectrogramAxes;
    cla(axSpec);

    if ~compareMode
        % Single spectrogram (current filter)
        aF = app.applyFilters(a, curFilt);
        tiledlayout(axSpec,1,1,'TileSpacing','compact','Padding','compact');
        ax1 = nexttile(axSpec);
        spectrogram(aF, 1024, 768, Nfft, fs, 'yaxis');
        title(ax1,'Spectrogram (Current Filter)');
        ylabel(ax1,'Frequency (Hz)');
        xlabel(ax1,'Time (s)');
        colormap(ax1, 'parula');

    else
        % Two vertically stacked spectrograms: A (top), B (bottom)
        tiledlayout(axSpec,2,1,'TileSpacing','compact','Padding','compact');

        % A
        ax1 = nexttile(axSpec);
        spectrogram(aA, 1024, 768, Nfft, fs, 'yaxis');
        title(ax1,'Spectrogram - Filter A');
        ylabel(ax1,'Frequency (Hz)');
        colormap(ax1, 'parula');

        % B
        ax2 = nexttile(axSpec);
        spectrogram(aB, 1024, 768, Nfft, fs, 'yaxis');
        title(ax2,'Spectrogram - Filter B');
        ylabel(ax2,'Frequency (Hz)');
        xlabel(ax2,'Time (s)');
        colormap(ax2, 'parula');

        linkaxes([ax1 ax2],'x');
    end

    % ---------------------------------------------------------------------
    % 3) Time histories tab (TimeAxes)
    % ---------------------------------------------------------------------
    axTimeParent = app.TimeAxes;
    cla(axTimeParent);

    tiledlayout(axTimeParent,3,1,'TileSpacing','compact','Padding','compact');

    showA  = app.ShowAccelCheckBox.Value;
    showV  = app.ShowVelocityCheckBox.Value;
    showD  = app.ShowDisplacementCheckBox.Value;

    % Accel subplot
    axTA = nexttile(axTimeParent);
    if ~compareMode
        if showA
            yA = app.normalizeSignal(aF);
            plot(axTA, t, yA, 'k');
        end
        ylabel(axTA,'Accel');
        title(axTA,'Acceleration');
    else
        if showA
            yA_A = app.normalizeSignal(aA);
            yA_B = app.normalizeSignal(aB);
            plot(axTA, t, yA_A, 'k', t, yA_B, 'r');
            legend(axTA,{'A','B'},'Location','best');
        end
        ylabel(axTA,'Accel');
        title(axTA,'Acceleration (A vs B)');
    end

    % Velocity subplot
    axTV = nexttile(axTimeParent);
    if ~compareMode
        if showV
            yV = app.normalizeSignal(v);
            plot(axTV, t, yV, 'b');
        end
        ylabel(axTV,'Velocity');
        title(axTV,'Velocity');
    else
        if showV
            yV_A = app.normalizeSignal(vA);
            yV_B = app.normalizeSignal(vB);
            plot(axTV, t, yV_A, 'b', t, yV_B, 'm');
            legend(axTV,{'A','B'},'Location','best');
        end
        ylabel(axTV,'Velocity');
        title(axTV,'Velocity (A vs B)');
    end

    % Displacement subplot
    axTD = nexttile(axTimeParent);
    if ~compareMode
        if showD
            yD = app.normalizeSignal(d);
            plot(axTD, t, yD, 'r');
        end
        ylabel(axTD,'Disp');
        xlabel(axTD,'Time (s)');
        title(axTD,'Displacement');
    else
        if showD
            yD_A = app.normalizeSignal(dA);
            yD_B = app.normalizeSignal(dB);
            plot(axTD, t, yD_A, 'r', t, yD_B, 'c');
            legend(axTD,{'A','B'},'Location','best');
        end
        ylabel(axTD,'Disp');
        xlabel(axTD,'Time (s)');
        title(axTD,'Displacement (A vs B)');
    end

    linkaxes([axTA axTV axTD],'x');

    % ---------------------------------------------------------------------
    % 4) FFT tab (FFTAxes)
    % ---------------------------------------------------------------------
    axFFTParent = app.FFTAxes;
    cla(axFFTParent);

    tiledlayout(axFFTParent,3,1,'TileSpacing','compact','Padding','compact');

    % Accel FFT
    axFA = nexttile(axFFTParent);
    if ~compareMode
        if showA
            loglog(axFA, fvec, abs(A), 'k');
        end
        ylabel(axFA,'|A(f)|');
        title(axFA,'Acceleration Spectrum');
    else
        if showA
            loglog(axFA, fvec, abs(A_A), 'k', fvec, abs(A_B), 'r');
            legend(axFA,{'A','B'},'Location','best');
        end
        ylabel(axFA,'|A(f)|');
        title(axFA,'Acceleration Spectrum (A vs B)');
    end
    app.applyFFTScale(axFA);

    % Velocity FFT
    axFV = nexttile(axFFTParent);
    if ~compareMode
        if showV
            loglog(axFV, fvec, abs(V), 'b');
        end
        ylabel(axFV,'|V(f)|');
        title(axFV,'Velocity Spectrum');
    else
        if showV
            loglog(axFV, fvec, abs(V_A), 'b', fvec, abs(V_B), 'm');
            legend(axFV,{'A','B'},'Location','best');
        end
        ylabel(axFV,'|V(f)|');
        title(axFV,'Velocity Spectrum (A vs B)');
    end
    app.applyFFTScale(axFV);

    % Displacement FFT
    axFD = nexttile(axFFTParent);
    if ~compareMode
        if showD
            loglog(axFD, fvec, abs(D), 'r');
        end
        ylabel(axFD,'|D(f)|');
        xlabel(axFD,'Frequency (Hz)');
        title(axFD,'Displacement Spectrum');
    else
        if showD
            loglog(axFD, fvec, abs(D_A), 'r', fvec, abs(D_B), 'c');
            legend(axFD,{'A','B'},'Location','best');
        end
        ylabel(axFD,'|D(f)|');
        xlabel(axFD,'Frequency (Hz)');
        title(axFD,'Displacement Spectrum (A vs B)');
    end
    app.applyFFTScale(axFD);

    linkaxes([axFA axFV axFD],'x');

    % ---------------------------------------------------------------------
    % 5) Band-limited displacement tab (BandAxes)
    % ---------------------------------------------------------------------
    axBand = app.BandAxes;
    cla(axBand);
    hold(axBand,'on');

    % Define bands (you can replace with a table later if you like)
    bands = [5 10;
             10 20;
             20 50;
             50 200;
             200 2000];

    mode = app.BandPlotModeDropDown.Value;

    if ~compareMode
        % Normal mode: use current filter
        for k = 1:size(bands,1)
            f1 = bands(k,1);
            f2 = bands(k,2);

            dB = app.bandLimitedDisp(aF, fs, t, f1, f2);

            switch mode
                case 'Offset'
                    offset = (k-1) * max(abs(dB)) * 2;
                    y = dB + offset;
                case 'Overlay'
                    y = dB;
                case 'Normalize'
                    y = dB ./ max(abs(dB));
            end

            plot(axBand, t, y, 'LineWidth',1.1);
        end

        title(axBand,'Band-Limited Displacement (Current Filter)');
        xlabel(axBand,'Time (s)');
        ylabel(axBand,'Offset / Norm Disp');

    else
        % Compare mode: A and B in same layout
        for k = 1:size(bands,1)
            f1 = bands(k,1);
            f2 = bands(k,2);

            dB_A = app.bandLimitedDisp(aA, fs, t, f1, f2);
            dB_B = app.bandLimitedDisp(aB, fs, t, f1, f2);

            switch mode
                case 'Offset'
                    offset = (k-1) * max([abs(dB_A); abs(dB_B)]) * 2;
                    yA = dB_A + offset;
                    yB = dB_B + offset;
                case 'Overlay'
                    yA = dB_A;
                    yB = dB_B;
                case 'Normalize'
                    yA = dB_A ./ max(abs(dB_A));
                    yB = dB_B ./ max(abs(dB_B));
            end

            plot(axBand, t, yA, 'LineWidth',1.1,'Color',[0 0 0.7]);
            plot(axBand, t, yB, 'LineWidth',1.1,'Color',[0.8 0 0]);
        end

        title(axBand,'Band-Limited Displacement (A vs B)');
        xlabel(axBand,'Time (s)');
        ylabel(axBand,'Offset / Norm Disp');
        % Optional: legend for A/B
        % (Will be approximate since many lines)
        % legend(axBand,{'A','B'});
    end

    hold(axBand,'off');

end

% --- Button pushed function: StoreFilterAButton
function StoreFilterAButtonPushed(app, event)
    app.FilterA.hp    = app.HPField.Value;
    app.FilterA.lp    = app.LPField.Value;
    app.FilterA.order = app.OrderField.Value;
end

% --- Button pushed function: StoreFilterBButton
function StoreFilterBButtonPushed(app, event)
    app.FilterB.hp    = app.HPField.Value;
    app.FilterB.lp    = app.LPField.Value;
    app.FilterB.order = app.OrderField.Value;
end

% ================== Helper methods (private) ==================

methods (Access = private)

    function y = normalizeSignal(app, x)
        if app.NormalizeCheckBox.Value && ~isempty(x)
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

end
