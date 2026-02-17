function y = applyLowpass(app, x)
%APPLYLOWPASS  Apply lowpass filter using app.LowpassFreqField.

    fs = 1 / mean(diff(app.t));
    fc = app.LowpassFreqField.Value;

    if fc <= 0
        y = x;
        return;
    end

    [b,a] = butter(4, fc/(fs/2), 'low');
    y = filtfilt(b,a,x);
end
