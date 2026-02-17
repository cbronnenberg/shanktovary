function aF = filterAccel(app, aUS)
%FILTERACCEL  Apply the full filtering pipeline to acceleration in US units.
%
%   This merged version supports BOTH:
%       - The original UI checkbox controls (DetrendCheckBox, etc.)
%       - The new Filter Settings dialog properties (DetrendEnabled, etc.)
%       - Filter order and cutoff frequencies
%
%   It is fully backward-compatible and forward-compatible.

    % Start with the input
    x = aUS;

    %% ------------------------------------------------------------
    %  Resolve filtering settings (UI checkboxes OR dialog properties)
    % -------------------------------------------------------------
    useDetrend  = resolveFlag(app, 'DetrendCheckBox',  'DetrendEnabled');
    useTaper    = resolveFlag(app, 'TaperCheckBox',    'TaperEnabled');
    useHighpass = resolveFlag(app, 'HighpassCheckBox', 'HighpassEnabled');
    useLowpass  = resolveFlag(app, 'LowpassCheckBox',  'LowpassEnabled');

    hpFreq  = resolveValue(app, 'HighpassFreqField',  'HighpassFreq');
    lpFreq  = resolveValue(app, 'LowpassFreqField',   'LowpassFreq');
    hpOrder = resolveValue(app, 'HighpassOrderField', 'HighpassOrder');
    lpOrder = resolveValue(app, 'LowpassOrderField',  'LowpassOrder');

    fs = 1 / mean(diff(app.t));

    %% ------------------------------------------------------------
    % 1. Detrend (optional)
    % ------------------------------------------------------------
    if useDetrend
        x = detrend(x);
    end

    %% ------------------------------------------------------------
    % 2. Taper (optional)
    % ------------------------------------------------------------
    if useTaper
        x = applyTaper(app, x);
    end

    %% ------------------------------------------------------------
    % 3. Highpass (optional)
    % ------------------------------------------------------------
    if useHighpass && hpFreq > 0
        [b,a] = butter(hpOrder, hpFreq/(fs/2), 'high');
        x = filtfilt(b,a,x);
    end

    %% ------------------------------------------------------------
    % 4. Lowpass (optional)
    % ------------------------------------------------------------
    if useLowpass && lpFreq > 0
        [b,a] = butter(lpOrder, lpFreq/(fs/2), 'low');
        x = filtfilt(b,a,x);
    end

    %% ------------------------------------------------------------
    % Output
    % ------------------------------------------------------------
    aF = x;

end


%% ========================================================================
%  Helper: Resolve boolean flag from UI checkbox OR app property
% ========================================================================
function val = resolveFlag(app, uiName, propName)
    if isprop(app, uiName) && ~isempty(app.(uiName)) && isvalid(app.(uiName))
        val = app.(uiName).Value;
    else
        val = app.(propName);
    end
end

%% ========================================================================
%  Helper: Resolve numeric value from UI field OR app property
% ========================================================================
function val = resolveValue(app, uiName, propName)
    if isprop(app, uiName) && ~isempty(app.(uiName)) && isvalid(app.(uiName))
        val = app.(uiName).Value;
    else
        val = app.(propName);
    end
end
