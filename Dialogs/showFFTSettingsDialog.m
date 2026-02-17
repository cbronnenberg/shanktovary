function showFFTSettingsDialog(app)
%SHOWFFTSETTINGSDIALOG  Modal dialog for FFT/PSD settings.
%
%   Updated to use the FFT dropdown and maintain helper function usage.

%% ------------------------------------------------------------------------
%  1. Create modal dialog
% -------------------------------------------------------------------------
d = uifigure('Name','FFT / PSD Settings', ...
             'WindowStyle','modal', ...
             'Position',[100 100 380 300]);

%% ------------------------------------------------------------------------
%  2. FFT Length (Dropdown)
% -------------------------------------------------------------------------
uilabel(d, 'Text','FFT Length:', ...
           'Position',[20 240 120 22]);

fftDrop = uidropdown(d, ...
    'Items', {'1024','2048','4096','8192','16384'}, ...
    'Position',[150 240 120 22]);

% Preselect current value
if isprop(app,'NfftDropDown') && isvalid(app.NfftDropDown)
    fftDrop.Value = app.NfftDropDown.Value;
else
    fftDrop.Value = num2str(app.Nfft);
end

%% ------------------------------------------------------------------------
%  3. Window Percentage
% -------------------------------------------------------------------------
uilabel(d,'Text','Window %:', ...
          'Position',[20 200 120 22]);

winField = uieditfield(d,'numeric', ...
    'Limits',[0 100], ...
    'Value', app.WindowPct, ...
    'Position',[150 200 120 22]);

%% ------------------------------------------------------------------------
%  4. Overlap Percentage
% -------------------------------------------------------------------------
uilabel(d,'Text','Overlap %:', ...
          'Position',[20 160 120 22]);

ovField = uieditfield(d,'numeric', ...
    'Limits',[0 99], ...
    'Value', app.OverlapPct, ...
    'Position',[150 160 120 22]);

%% ------------------------------------------------------------------------
%  5. Window Type
% -------------------------------------------------------------------------
uilabel(d,'Text','Window Type:', ...
          'Position',[20 120 120 22]);

winTypeDrop = uidropdown(d, ...
    'Items', {'Hann','Hamming','Blackman','Rectangular'}, ...
    'Value', app.WindowType, ...
    'Position',[150 120 120 22]);

%% ------------------------------------------------------------------------
%  6. Reset to Defaults
% -------------------------------------------------------------------------
uibutton(d,'Text','Reset Defaults', ...
    'Position',[20 60 120 30], ...
    'ButtonPushedFcn', @(~,~) resetDefaults());

    function resetDefaults()
        fftDrop.Value = '8192';
        winField.Value = 50;
        ovField.Value = 50;
        winTypeDrop.Value = 'Hann';
    end

%% ------------------------------------------------------------------------
%  7. OK / Cancel Buttons
% -------------------------------------------------------------------------
uibutton(d,'Text','Cancel', ...
    'Position',[60 20 100 30], ...
    'ButtonPushedFcn', @(~,~) close(d));

uibutton(d,'Text','OK', ...
    'Position',[180 20 100 30], ...
    'ButtonPushedFcn', @(~,~) onOK());

%% ------------------------------------------------------------------------
%  8. OK Callback
% -------------------------------------------------------------------------
    function onOK()

        % Update FFT length dropdown in main app
        if isprop(app,'NfftDropDown') && isvalid(app.NfftDropDown)
            app.NfftDropDown.Value = fftDrop.Value;
        end

        % Update fallback property
        app.Nfft = str2double(fftDrop.Value);

        % Update window settings
        app.WindowPct   = winField.Value;
        app.OverlapPct  = ovField.Value;
        app.WindowType  = winTypeDrop.Value;

        % Refresh plots
        refreshAllPlots(app);

        close(d);
    end

end
