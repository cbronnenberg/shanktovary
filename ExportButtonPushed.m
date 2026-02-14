function ExportButtonPushed(app, event)
    out = app.exportCurrentResults();
    assignin('base','VibResults', out);
end

