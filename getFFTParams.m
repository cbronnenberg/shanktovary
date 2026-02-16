function params = getFFTParams(app)

    switch app.WindowType
        case 'Hamming'
            w = hamming(app.WindowLength);
        case 'Hann'
            w = hann(app.WindowLength);
        case 'Blackman'
            w = blackman(app.WindowLength);
        case 'FlatTop'
            w = flattopwin(app.WindowLength);
    end

    params = struct( ...
        'Nfft',          app.Nfft, ...
        'WindowLength',  app.WindowLength, ...
        'OverlapLength', app.OverlapLength, ...
        'WindowPct',     app.WindowPct, ...
        'OverlapPct',    app.OverlapPct, ...
        'Window',        w );
end



