function showFFTSettingsDialog(app)

    % Create modal dialog
    d = uifigure('Name','FFT / PSD Settings', ...
                 'WindowStyle','modal', ...
                 'Position',[100 100 360 260]);

    gl = uigridlayout(d, [5 2]);
    gl.RowHeight = {30,30,30,30,'1x'};
    gl.ColumnWidth = {'1x','1x'};
    gl.Padding = [10 10 10 10];
    gl.RowSpacing = 8;

    % --- FFT Length Dropdown ---
    uilabel(gl, 'Text','FFT Length:');
    nfftDD = uidropdown(gl, ...
        'Items', {'512','1024','2048','4096','8192','16384','32768','65536'}, ...
        'Value', num2str(app.Nfft));

    % --- Window Percentage ---
    uilabel(gl, 'Text','Window (% of Nfft):');
    winField = uieditfield(gl, 'numeric', ...
        'Limits',[1 100], ...
        'Value', app.WindowPct);

    % --- Overlap Percentage ---
    uilabel(gl, 'Text','Overlap (% of Window):');
    ovField = uieditfield(gl, 'numeric', ...
        'Limits',[0 99], ...
        'Value', app.OverlapPct);

    % --- Window Type (optional) ---
    uilabel(gl, 'Text','Window Type:');
    winTypeDD = uidropdown(gl, ...
        'Items', {'Hamming','Hann','Blackman','FlatTop'}, ...
        'Value', app.WindowType);

    % --- Buttons ---
    okBtn = uibutton(gl, 'Text','OK', ...
        'ButtonPushedFcn', @(~,~) onOK());
    cancelBtn = uibutton(gl, 'Text','Cancel', ...
        'ButtonPushedFcn', @(~,~) delete(d));

    okBtn.Layout.Row = 5; okBtn.Layout.Column = 1;
    cancelBtn.Layout.Row = 5; cancelBtn.Layout.Column = 2;

    % ------------------------------------------------------------
    % OK BUTTON CALLBACK
    % ------------------------------------------------------------
    function onOK()

        % Update app properties
        app.Nfft        = str2double(nfftDD.Value);
        app.WindowPct   = winField.Value;
        app.OverlapPct  = ovField.Value;
        app.WindowType  = winTypeDD.Value;

        % Derived parameters
        app.WindowLength  = round(app.WindowPct/100 * app.Nfft);
        app.OverlapLength = round(app.OverlapPct/100 * app.WindowLength);

        % Refresh all spectral plots
        app.updateFFTPlot();
        app.updatePSDPlot();
        app.updateSpectrogramPlot();
        app.updateBandPlot();

        delete(d);
    end

end

