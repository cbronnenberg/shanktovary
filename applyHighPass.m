function y = applyHighpass(app, x)
%APPLYHIGHPASS  Apply highpass filter using app.HighpassFreqField.

    fs = 1 / mean(diff(app.t));
    fc = app.HighpassFreqField.Value;

    if fc <= 0
        y = x;
        return;
    end

    [b,a] = butter(4, fc/(fs/2), 'high');
    y = filtfilt(b,a,x);
end
