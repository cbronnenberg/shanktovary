function runBatch(app)
    % Run batch processing on all files
    results = app.computeBatch();

    % Store results
    app.BatchResults = results;

    % Update batch tab
    app.updateBatchPlot();
end

% app.RunBatchButton.ButtonPushedFcn = @(~,~) app.runBatch();
