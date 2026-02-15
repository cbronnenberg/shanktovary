function RunBatchButtonPushed(app)
    switch app.BatchModeDropDown.Value
        case "Absolute"
            app.runAbsoluteBatch();
        case "Relative"
            app.runRelativeBatch();
        case "Both"
            app.runAbsoluteBatch();
            app.runRelativeBatch();
    end
end
