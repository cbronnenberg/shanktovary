function vib_dashboard(a, fs)

% a: acceleration vector
% fs: sampling frequency

t = (0:length(a)-1)'/fs;

%% --- Create UI Figure ---
f = figure('Name','Vibration Integration Dashboard','Position',[100 100 1400 900]);

% Controls panel
ctrl = uipanel(f,'Title','Controls','Position',[0.01 0.01 0.18 0.98]);

% High-pass cutoff
uicontrol(ctrl,'Style','text','String','High-pass (Hz)','Position',[10 820 120 20]);
hpBox = uicontrol(ctrl,'Style','edit','String','10','Position',[130 820 50 25]);

% Low-pass cutoff
uicontrol(ctrl,'Style','text','String','Low-pass (Hz)','Position',[10 780 120 20]);
lpBox = uicontrol(ctrl,'Style','edit','String','2000','Position',[130 780 50 25]);

% Filter order
uicontrol(ctrl,'Style','text','String','Filter Order','Position',[10 740 120 20]);
ordBox = uicontrol(ctrl,'Style','edit','String','6','Position',[130 740 50 25]);

% Band table
uicontrol(ctrl,'Style','text','String','Bands (Hz)','Position',[10 690 120 20]);
bandTable = uitable(ctrl,'Data',[5 10; 10 20; 20 50; 50 200; 200 2000], ...
    'ColumnName',{'f1','f2'}, 'Position',[10 500 170 180]);

% Update button
uicontrol(ctrl,'Style','pushbutton','String','Update','FontSize',12, ...
    'Position',[10 450 170 40],'Callback',@(~,~) updatePlots());

%% --- Axes Layout ---
ax1 = subplot('Position',[0.22 0.70 0.75 0.27]); % Spectrogram
ax2 = subplot('Position',[0.22 0.50 0.75 0.17]); % FFT
ax3 = subplot('Position',[0.22 0.30 0.75 0.17]); % Time histories
ax4 = subplot('Position',[0.22 0.05 0.75 0.20]); % Band-limited

%% --- Update Function ---
    function updatePlots()
        hp = str2double(hpBox.String);
        lp = str2double(lpBox.String);
        ord = str2double(ordBox.String);
        bands = bandTable.Data;

        % --- Filtering ---
        dHP = designfilt('highpassiir','FilterOrder',ord, ...
            'HalfPowerFrequency',hp,'SampleRate',fs);
        dLP = designfilt('lowpassiir','FilterOrder',ord, ...
            'HalfPowerFrequency',lp,'SampleRate',fs);

        aF = filtfilt(dHP, filtfilt(dLP, a));

        % --- Integrations ---
        v = cumtrapz(t, aF);
        d = cumtrapz(t, v);

        % --- Spectrogram ---
        axes(ax1); cla;
        spectrogram(aF, 2048, 1024, 4096, fs, 'yaxis');
        title('Acceleration Spectrogram');

        % --- FFTs ---
        A = fft(aF);
        V = fft(v);
        D = fft(d);
        N = length(a);
        fvec = (0:N-1)'*(fs/N);

        axes(ax2); cla;
        loglog(fvec, abs(A), 'k'); hold on;
        loglog(fvec, abs(V), 'b');
        loglog(fvec, abs(D), 'r');
        xlim([1 2000]);
        legend('Accel','Vel','Disp');
        title('Spectral Growth Through Integration');

        % --- Time Histories ---
        axes(ax3); cla;
        plot(t, aF, 'k'); hold on;
        plot(t, v, 'b');
        plot(t, d, 'r');
        legend('Accel','Vel','Disp');
        title('Time Histories');

        % --- Band-Limited Reconstructions ---
        axes(ax4); cla;
        hold on;
        for k = 1:size(bands,1)
            f1 = bands(k,1); f2 = bands(k,2);
            dB = bandLimitedDisp(aF, fs, t, f1, f2);
            plot(t, dB + (k-1)*max(abs(dB))*2, 'LineWidth',1.1);
        end
        title('Band-Limited Displacement Contributions');
        hold off;
    end

end

%% --- Helper Function ---
function dB = bandLimitedDisp(a, fs, t, f1, f2)
    d = designfilt('bandpassiir','FilterOrder',6, ...
        'HalfPowerFrequency1',f1,'HalfPowerFrequency2',f2, ...
        'SampleRate',fs);
    aB = filtfilt(d, a);
    vB = cumtrapz(t, aB);
    dB = cumtrapz(t, vB);
end

