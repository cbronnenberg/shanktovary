%% plotTitles.m

function plotTitles()
title(app.AxSpectrogram,'Acceleration Spectrogram');
title(app.AxFFT,'Spectral Growth Through Integration');
legend(app.AxFFT,{'Accel','Vel','Disp'});
title(app.AxTime,'Time Histories');
title(app.AxBands,'Band-Limited Displacement Contributions');

end