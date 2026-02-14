%% BandTableCellSelection.m
% 
function BandTableCellSelection(app, event)
    % event.Indices = [row, col]
    idx = event.Indices;

    if isempty(idx)
        return
    end

    row = idx(1);

    % Extract f1 and f2 from the table
    bands = app.BandTable.Data;

    if row <= size(bands,1)
        f1 = bands(row,1);
        f2 = bands(row,2);

        % Store them as app properties for later use
        app.SelectedBand = [f1 f2];

        % Optional: print to Command Window for debugging
        fprintf('Selected band: %.1f – %.1f Hz\n', f1, f2);
    end
end


UpdateButtomPushed()
if ~isempty(app.SelectedBand)
    f1 = app.SelectedBand(1);
    f2 = app.SelectedBand(2);

    dB = app.bandLimitedDisp(aF, fs, t, f1, f2);

    % Plot it or highlight it
    plot(app.AxBands, t, dB, 'LineWidth', 2, 'Color', 'm');
end
