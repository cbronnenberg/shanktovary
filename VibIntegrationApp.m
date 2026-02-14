Aclassdef VibIntegrationApp < matlab.apps.AppBase

    %----------------------------------------------------------------------
    % Properties
    %----------------------------------------------------------------------
    properties (Access = public)
        UIFigure matlab.ui.Figure
        ControlPanel matlab.ui.container.Panel

        HPLabel matlab.ui.control.Label
        HPField matlab.ui.control.NumericEditField

        LPLabel matlab.ui.control.Label
        LPField matlab.ui.control.NumericEditField

        OrderLabel matlab.ui.control.Label
        OrderField matlab.ui.control.NumericEditField

        BandTable matlab.ui.control.Table
        UpdateButton matlab.ui.control.Button

        AxSpectrogram matlab.ui.control.UIAxes
        AxFFT matlab.ui.control.UIAxes
        AxTime matlab.ui.control.UIAxes
        AxBands matlab.ui.control.UIAxes

        % Data
        a double
        fs double
        t double
    end

    %----------------------------------------------------------------------
    % App Initialization
    %----------------------------------------------------------------------
    methods (Access = private)

        function startupFcn(app, accel, fs)
            app.a = accel(:);
            app.fs = fs;
            app.t = (0:length(accel)-1)'/fs;
        end

        function createComponents(app)
            % Main figure
            app.UIFigure = uifigure('Name','Vibration Integration Dashboard',...
                'Position',[100 100 1400 900]);

            % Control panel
            app.ControlPanel = uipanel(app.UIFigure,'Title','Controls',...
                'Position',[10 10 250 880]);

            % High-pass
            app.HPLabel = uilabel(app.ControlPanel,'Text','High-pass (Hz)',...
                'Position',[10 820 120 20]);
            app.HPField = uieditfield(app.ControlPanel,'numeric',...
                'Value',10,'Position',[150 820 70 25]);

            % Low-pass
            app.LPLabel = uilabel(app.ControlPanel,'Text','Low-pass (Hz)',...
                'Position',[10 780 120 20]);
            app.LPField = uieditfield(app.ControlPanel,'numeric',...
                'Value',2000,'Position',[150 780 70 25]);

            % Filter order
            app.OrderLabel = uilabel(app.ControlPanel,'Text','Filter Order',...
                'Position',[10 740 120 20]);
            app.OrderField = uieditfield(app.ControlPanel,'numeric',...
                'Value',6,'Position',[150 740 70 25]);

            % Band table
            uilabel(app.ControlPanel,'Text','Bands (Hz)',...
                'Position',[10 700 120 20]);

            app.BandTable = uitable(app.ControlPanel,...
                'Data',[5 10; 10 20; 20 50; 50 200; 200 2000],...
                'ColumnName',{'f1','f2'},...
                'Position',[10 500 220 180]);

            % Update button
            app.UpdateButton = uibutton(app.ControlPanel,'push',...
                'Text','Update','FontSize',14,...
                'Position',[10 450 220 40],...
                'ButtonPushedFcn',@(btn,event) app.updatePlots());

            % Axes
            app.AxSpectrogram = uiaxes(app.UIFigure,...
                'Position',[280 650 1100 230],...
                'Title','Acceleration Spectrogram');

            app.AxFFT = uiaxes(app.UIFigure,...
                'Position',[280 480 1100 160],...
                'Title','Spectral Growth Through Integration');

            app.AxTime = uiaxes(app.UIFigure,...
                'Position',[280 300 1100 160],...
                'Title','Time Histories');

            app.AxBands = uiaxes(app.UIFigure,...
                'Position',[280 50 1100 220],...
                'Title','Band-Limited Displacement Contributions');
        end

    end

    %----------------------------------------------------------------------
    % Core Logic
    %----------------------------------------------------------------------
    methods (Access = private)

        function updatePlots(app)
            hp = app.HPField.Value;
            lp = app.LPField.Value;
            ord = app.OrderField.Value;
            bands = app.BandTable.Data;

            fs = app.fs;
            t = app.t;
            a = app.a;

            %--------------------------
            % Filtering
            %--------------------------
            dHP = designfilt('highpassiir','FilterOrder',ord,...
                'HalfPowerFrequency',hp,'SampleRate',fs);

            dLP = designfilt('lowpassiir','FilterOrder',ord,...
                'HalfPowerFrequency',lp,'SampleRate',fs);

            aF = filtfilt(dHP, filtfilt(dLP, a));

            %--------------------------
            % Integrations
            %--------------------------
            v = cumtrapz(t, aF);
            d = cumtrapz(t, v);

            %--------------------------
            % Spectrogram
            %--------------------------
            ax = app.AxSpectrogram;
            cla(ax);
            spectrogram(aF, 2048, 1024, 4096, fs, 'yaxis','Parent',ax);
            title(ax,'Acceleration Spectrogram');

            %--------------------------
            % FFTs
            %--------------------------
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

            %--------------------------
            % Time Histories
            %--------------------------
            ax = app.AxTime;
            cla(ax);
            plot(ax, t, aF,'k'); hold(ax,'on');
            plot(ax, t, v,'b');
            plot(ax, t, d,'r');
            legend(ax,{'Accel','Vel','Disp'});
            title(ax,'Time Histories');

            %--------------------------
            % Band-Limited Reconstructions
            %--------------------------
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

        %------------------------------------------------------------------
        % Helper: Band-limited displacement
        %------------------------------------------------------------------
        function dB = bandLimitedDisp(app, a, fs, t, f1, f2)
            d = designfilt('bandpassiir','FilterOrder',6,...
                'HalfPowerFrequency1',f1,...
                'HalfPowerFrequency2',f2,...
                'SampleRate',fs);

            aB = filtfilt(d, a);
            vB = cumtrapz(t, aB);
            dB = cumtrapz(t, vB);
        end

    end

    %----------------------------------------------------------------------
    % App Constructor
    %----------------------------------------------------------------------
    methods (Access = public)

        function app = VibIntegrationApp(accel, fs)
            createComponents(app)
            startupFcn(app, accel, fs)
        end

    end
end

Aclassdef VibIntegrationApp < matlab.apps.AppBase

    %----------------------------------------------------------------------
    % Properties
    %----------------------------------------------------------------------
    properties (Access = public)
        UIFigure matlab.ui.Figure
        ControlPanel matlab.ui.container.Panel

        HPLabel matlab.ui.control.Label
        HPField matlab.ui.control.NumericEditField

        LPLabel matlab.ui.control.Label
        LPField matlab.ui.control.NumericEditField

        OrderLabel matlab.ui.control.Label
        OrderField matlab.ui.control.NumericEditField

        BandTable matlab.ui.control.Table
        UpdateButton matlab.ui.control.Button

        AxSpectrogram matlab.ui.control.UIAxes
        AxFFT matlab.ui.control.UIAxes
        AxTime matlab.ui.control.UIAxes
        AxBands matlab.ui.control.UIAxes

        % Data
        a double
        fs double
        t double
    end

    %----------------------------------------------------------------------
    % App Initialization
    %----------------------------------------------------------------------
    methods (Access = private)

        function startupFcn(app, accel, fs)
            app.a = accel(:);
            app.fs = fs;
            app.t = (0:length(accel)-1)'/fs;
        end

        function createComponents(app)
            % Main figure
            app.UIFigure = uifigure('Name','Vibration Integration Dashboard',...
                'Position',[100 100 1400 900]);

            % Control panel
            app.ControlPanel = uipanel(app.UIFigure,'Title','Controls',...
                'Position',[10 10 250 880]);

            % High-pass
            app.HPLabel = uilabel(app.ControlPanel,'Text','High-pass (Hz)',...
                'Position',[10 820 120 20]);
            app.HPField = uieditfield(app.ControlPanel,'numeric',...
                'Value',10,'Position',[150 820 70 25]);

            % Low-pass
            app.LPLabel = uilabel(app.ControlPanel,'Text','Low-pass (Hz)',...
                'Position',[10 780 120 20]);
            app.LPField = uieditfield(app.ControlPanel,'numeric',...
                'Value',2000,'Position',[150 780 70 25]);

            % Filter order
            app.OrderLabel = uilabel(app.ControlPanel,'Text','Filter Order',...
                'Position',[10 740 120 20]);
            app.OrderField = uieditfield(app.ControlPanel,'numeric',...
                'Value',6,'Position',[150 740 70 25]);

            % Band table
            uilabel(app.ControlPanel,'Text','Bands (Hz)',...
                'Position',[10 700 120 20]);

            app.BandTable = uitable(app.ControlPanel,...
                'Data',[5 10; 10 20; 20 50; 50 200; 200 2000],...
                'ColumnName',{'f1','f2'},...
                'Position',[10 500 220 180]);

            % Update button
            app.UpdateButton = uibutton(app.ControlPanel,'push',...
                'Text','Update','FontSize',14,...
                'Position',[10 450 220 40],...
                'ButtonPushedFcn',@(btn,event) app.updatePlots());

            % Axes
            app.AxSpectrogram = uiaxes(app.UIFigure,...
                'Position',[280 650 1100 230],...
                'Title','Acceleration Spectrogram');

            app.AxFFT = uiaxes(app.UIFigure,...
                'Position',[280 480 1100 160],...
                'Title','Spectral Growth Through Integration');

            app.AxTime = uiaxes(app.UIFigure,...
                'Position',[280 300 1100 160],...
                'Title','Time Histories');

            app.AxBands = uiaxes(app.UIFigure,...
                'Position',[280 50 1100 220],...
                'Title','Band-Limited Displacement Contributions');
        end

    end

    %----------------------------------------------------------------------
    % Core Logic
    %----------------------------------------------------------------------
    methods (Access = private)

        function updatePlots(app)
            hp = app.HPField.Value;
            lp = app.LPField.Value;
            ord = app.OrderField.Value;
            bands = app.BandTable.Data;

            fs = app.fs;
            t = app.t;
            a = app.a;

            %--------------------------
            % Filtering
            %--------------------------
            dHP = designfilt('highpassiir','FilterOrder',ord,...
                'HalfPowerFrequency',hp,'SampleRate',fs);

            dLP = designfilt('lowpassiir','FilterOrder',ord,...
                'HalfPowerFrequency',lp,'SampleRate',fs);

            aF = filtfilt(dHP, filtfilt(dLP, a));

            %--------------------------
            % Integrations
            %--------------------------
            v = cumtrapz(t, aF);
            d = cumtrapz(t, v);

            %--------------------------
            % Spectrogram
            %--------------------------
            ax = app.AxSpectrogram;
            cla(ax);
            spectrogram(aF, 2048, 1024, 4096, fs, 'yaxis','Parent',ax);
            title(ax,'Acceleration Spectrogram');

            %--------------------------
            % FFTs
            %--------------------------
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

            %--------------------------
            % Time Histories
            %--------------------------
            ax = app.AxTime;
            cla(ax);
            plot(ax, t, aF,'k'); hold(ax,'on');
            plot(ax, t, v,'b');
            plot(ax, t, d,'r');
            legend(ax,{'Accel','Vel','Disp'});
            title(ax,'Time Histories');

            %--------------------------
            % Band-Limited Reconstructions
            %--------------------------
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

        %------------------------------------------------------------------
        % Helper: Band-limited displacement
        %------------------------------------------------------------------
        function dB = bandLimitedDisp(app, a, fs, t, f1, f2)
            d = designfilt('bandpassiir','FilterOrder',6,...
                'HalfPowerFrequency1',f1,...
                'HalfPowerFrequency2',f2,...
                'SampleRate',fs);

            aB = filtfilt(d, a);
            vB = cumtrapz(t, aB);
            dB = cumtrapz(t, vB);
        end

    end

    %----------------------------------------------------------------------
    % App Constructor
    %----------------------------------------------------------------------
    methods (Access = public)

        function app = VibIntegrationApp(accel, fs)
            createComponents(app)
            startupFcn(app, accel, fs)
        end

    end
end
