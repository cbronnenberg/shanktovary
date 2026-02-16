function updateBandLimitedPlot(app)
%UPDATEBANDLIMITEDPLOT  Refresh the band-limited RMS plot.

%% Startup guards
if isempty(app) || ~isvalid(app)
    return
end
if isempty(app.BandLimitedPanel) || ~isvalid(app.BandLimitedPanel)
    return
end
if isempty(app.curSignals) || isempty(app.curSignals.aF)
    return
end

%% Read UI state
compareMode = app.CompareFiltersCheckBox.Value && ...
              ~isempty(app.ASignals) && ~isempty(app.BSignals);

%% Clear only axes/tiledlayouts
delete(findall(app.BandLimitedPanel, 'Type', 'axes'));
delete(findall(app.BandLimitedPanel, 'Type', 'tiledlayout'));

%% Create layout
tl = tiledlayout(app.BandLimitedPanel, 1, 1, ...
    'TileSpacing', 'compact', ...
    'Padding', 'compact');

ax = nexttile(tl);

%% Compute band-limited RMS
bands = app.BandTable.Data;   % assuming Nx2 [low high]

if ~compareMode
    rmsVals = computeBandRMS(app.curSignals, bands);
    bar(ax, rmsVals);
    title(ax, 'Band-Limited RMS');
else
    rmsA = computeBandRMS(app.ASignals, bands);
    rmsB = computeBandRMS(app.BSignals, bands);
    bar(ax, [rmsA(:) rmsB(:)]);
    legend(ax, {'A','B'});
    title(ax, 'Band-Limited RMS (A vs B)');
end

xlabel(ax, 'Band Index');
ylabel(ax, 'RMS');
grid(ax, 'on');

end


%% Helper
function rmsVals = computeBandRMS(sigStruct, bands)
    nBands = size(bands,1);
    rmsVals = zeros(nBands,1);
    for k = 1:nBands
        idx = sigStruct.f >= bands{k,1} & sigStruct.f <= bands{k,2};
        rmsVals(k) = sqrt(mean(sigStruct.Amp(idx).^2));
    end
end
