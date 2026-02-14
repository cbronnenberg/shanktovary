function updateBandLimited(app)

    parent = app.BandPanel;
    delete(parent.Children);

    hold(parent,'on');

    compareMode = app.CompareFiltersCheckBox.Value && ...
                  ~isempty(app.ASignals) && ~isempty(app.BSignals);

    t = app.t;
    fs = app.fs;

    % Define bands
    bands = [5 10;
             10 20;
             20 50;
             50 200;
             200 2000];

    mode = app.BandPlotModeDropDown.Value;

    bandNames = strcat(string(bands(:,1)),"–",string(bands(:,2))," Hz");
    rmsA = nan(size(bands,1),1);
    rmsB = nan(size(bands,1),1);

    if ~compareMode
        % Normal mode
        aF = app.curSignals.aF;

        for k = 1:size(bands,1)
            f1 = bands(k,1);
            f2 = bands(k,2);

            dB = app.bandLimitedDisp(aF, fs, t, f1, f2);
            rmsA(k) = rms(dB);

            switch mode
                case 'Offset'
                    offset = (k-1)*max(abs(dB))*2;
                    y = dB + offset;
                case 'Overlay'
                    y = dB;
                case 'Normalize'
                    y = dB ./ max(abs(dB));
            end

            plot(parent, t, y, 'LineWidth',1.1);
        end

        title(parent,'Band-Limited Displacement (Current Filter)');
        xlabel(parent,'Time (s)');
        ylabel(parent,'Offset / Norm Disp');

    else
        % Compare mode: A and B in same layout
        aA = app.ASignals.aF;
        aB = app.BSignals.aF;

        for k = 1:size(bands,1)
            f1 = bands(k,1);
            f2 = bands(k,2);

            dA = app.bandLimitedDisp(aA, fs, t, f1, f2);
            dB = app.bandLimitedDisp(aB, fs, t, f1, f2);
            rmsA(k) = rms(dA);
            rmsB(k) = rms(dB);

            switch mode
                case 'Offset'
                    M = max([abs(dA); abs(dB)]);
                    offset = (k-1)*M*2;
                    yA = dA + offset;
                    yB = dB + offset;
                case 'Overlay'
                    yA = dA;
                    yB = dB;
                case 'Normalize'
                    yA = dA ./ max(abs(dA));
                    yB = dB ./ max(abs(dB));
            end

            plot(parent, t, yA, 'Color',[0 0 0.7],'LineWidth',1.1);
            plot(parent, t, yB, 'Color',[0.8 0 0],'LineWidth',1.1);
        end

        title(parent,'Band-Limited Displacement (A vs B)');
        xlabel(parent,'Time (s)');
        ylabel(parent,'Offset / Norm Disp');
    end

    if ~compareMode
        app.DominantBandsTable = table(bandNames, rmsA, ...
            'VariableNames', {'Band','RMS'});
    else
        app.DominantBandsTable = table(bandNames, rmsA, rmsB, ...
            'VariableNames', {'Band','RMS_A','RMS_B'});
    end

    % Optional: highlight dominant band in title
    [~, idxMax] = max(rmsA, [], 'omitnan');
    if ~isempty(idxMax) && ~isnan(idxMax)
        domLabel = bandNames(idxMax);
        title(parent, sprintf('%s | Dominant: %s', parent.Title.String, domLabel));
    end

    hold(parent,'off');


end
