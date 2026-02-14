function updateBandLimited(app)

    parent = app.BandPanel;
    delete(parent.Children);
    ax = axes('Parent', parent);
    hold(ax,'on');

    app.BandAxesHandle = ax;
    app.BandLineHandles = gobjects(nBands, 2);
    app.BandNames = bandNames;


    compareMode = app.CompareFiltersCheckBox.Value && ...
                  ~isempty(app.ASignals) && ~isempty(app.BSignals);

    t = app.t;
    fs = app.fs;

parent = app.BandPanel;
delete(parent.Children);
hold(parent,'on');

compareMode = app.CompareFiltersCheckBox.Value && ...
              ~isempty(app.ASignals) && ~isempty(app.BSignals);

t  = app.t;
fs = app.fs;

    % --- Get bands from UI if available, else fallback ---
    if isprop(app, 'BandsTable') && ~isempty(app.BandsTable) && ~isempty(app.BandsTable.Data)
        data  = app.BandsTable.Data;
        f1col = data(:,1);
        f2col = data(:,2);
        bands = [f1col f2col];
    else
        bands = [5 10;
                10 20;
                20 50;
                50 200;
                200 2000];
    end

    nBands    = size(bands,1);
    bandNames = strcat(string(bands(:,1)),"–",string(bands(:,2))," Hz");

    rmsA  = nan(nBands,1);
    rmsB  = nan(nBands,1);

colors = lines(nBands);   % one color per band

    if ~compareMode
        % Normal mode
        aF = app.curSignals.aF;

        for k = 1:size(nBands,1)
            f1 = bands(k,1);
            f2 = bands(k,2);

            dB = app.bandLimitedDisp(aF, fs, t, f1, f2);
            rmsA(k) = rms(dB);

            stats(k).rms  = rms(dB);
            stats(k).max  = max(dB);
            stats(k).min  = min(dB);
            stats(k).mean = mean(dB);

            switch mode
                case 'Offset'
                    offset = (k-1)*max(abs(dB))*2;
                    y = dB + offset;
                case 'Overlay'
                    y = dB;
                case 'Normalize'
                    y = dB ./ max(abs(dB));
            end

            plot(ax, t, y, 'LineWidth',1.1);
        end

        title(ax,'Band-Limited Displacement (Current Filter)');
        xlabel(ax,'Time (s)');
        ylabel(ax,'Offset / Norm Disp');
        legend(ax, bandNames, 'Location','eastoutside');


    else
        % Compare mode: A and B in same layout
        aA = app.ASignals.aF;
        aB = app.BSignals.aF;

        for k = 1:size(nBands,1)
            f1 = bands(k,1);
            f2 = bands(k,2);

            dA = app.bandLimitedDisp(aA, fs, t, f1, f2);
            dB = app.bandLimitedDisp(aB, fs, t, f1, f2);
            rmsA(k) = rms(dA);
            rmsB(k) = rms(dB);

            statsA(k).rms  = rms(dA);
            statsA(k).max  = max(dA);
            statsA(k).min  = min(dA);
            statsA(k).mean = mean(dA);

            statsB(k).rms  = rms(dB);
            statsB(k).max  = max(dB);
            statsB(k).min  = min(dB);
            statsB(k).mean = mean(dB);

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

            plot(ax, t, yA, 'Color', colors(k,:),'LineWidth',1.1, 'LineStyle','-');
            plot(ax, t, yB, 'Color', colors(k,:),'LineWidth',1.1, 'LineStyle','--');
        end

        title(ax,'Band-Limited Displacement (A vs B)');
        xlabel(ax,'Time (s)');
        ylabel(ax,'Offset / Norm Disp');
    end

    if ~compareMode
        app.DominantBandsTable = table(bandNames, rmsA, ...
            'VariableNames', {'Band','RMS'});
    else
        app.DominantBandsTable = table(bandNames, rmsA, rmsB, ...
            'VariableNames', {'Band','RMS_A','RMS_B'});
    end

    % highlight dominant band in title
    [~, idxMax] = max(rmsA, [], 'omitnan');
    if ~isempty(idxMax) && ~isnan(idxMax)
        domLabel = bandNames(idxMax);
        title(ax, sprintf('%s | Dominant: %s', parent.Title.String, domLabel));
    end

    hold(ax,'off');

    lines = {};
    for k = 1:nBands
        if ~compareMode
            lines{end+1} = sprintf('%s: RMS=%.3g, Max=%.3g, Min=%.3g, Mean=%.3g', ...
                bandNames(k), stats(k).rms, stats(k).max, stats(k).min, stats(k).mean);
        else
            lines{end+1} = sprintf('%s: A[RMS=%.3g] B[RMS=%.3g] Δ=%.3g', ...
                bandNames(k), statsA(k).rms, statsB(k).rms, ...
                statsB(k).rms - statsA(k).rms);
        end
    end
    app.BandStatsTextArea.Value = lines;



end
