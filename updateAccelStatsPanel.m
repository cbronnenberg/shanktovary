function updateAccelStatsPanel(app, name, a, invert)
    % RMS quick-look pane for acceleration data. Invert is used to flip the sign of the
    if invert
        a = -a;
    end

    a = app.convertAccelToSI(a);

    txt = sprintf(['%s\n' ...
                   'RMS: %.4g\n' ...
                   'Max: %.4g\n' ...
                   'Min: %.4g\n' ...
                   'Mean: %.4g'], ...
                   name, rms(a), max(a), min(a), mean(a));

    app.AccelStatsTextArea.Value = txt;
end
