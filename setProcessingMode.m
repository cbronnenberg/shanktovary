function setProcessingMode(app, mode)
    app.ProcessingMode = mode;
    app.updateStatusBar();

    switch mode
        case "Absolute"
            app.showAbsoluteUI();
        case "Relative"
            app.showRelativeUI();
        case "Batch"
            app.showBatchUI();
    end
end
