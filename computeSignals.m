function computeSignals(app)

    a  = app.a(:);
    fs = app.fs;
    t  = app.t(:);

    % Current filter
    curFilt.hp    = app.HPField.Value;
    curFilt.lp    = app.LPField.Value;
    curFilt.order = app.OrderField.Value;

    % FFT length
    Nfft = round(app.NfftField.Value);
    if Nfft <= 0
        Nfft = 8192;
    end

    compareMode = app.CompareFiltersCheckBox.Value && ...
                  ~isempty(app.FilterA) && ~isempty(app.FilterB);

    % -------------------------------------------------------------
    % Compute CURRENT filter signals
    % -------------------------------------------------------------
    aF = app.applyFilters(a, curFilt);
    v  = cumtrapz(t, aF);
    d  = cumtrapz(t, v);

    A = fft(aF, Nfft);
    V = fft(v,  Nfft);
    D = fft(d,  Nfft);

    app.curSignals = struct( ...
        'aF', aF, 'v', v, 'd', d, ...
        'A', A, 'V', V, 'D', D, ...
        'Nfft', Nfft, 'fvec', (0:Nfft-1)'*(fs/Nfft) ...
    );

    % -------------------------------------------------------------
    % Compute A/B signals if needed
    % -------------------------------------------------------------
    if compareMode
        % Filter A
        fA = app.FilterA;
        aA = app.applyFilters(a, fA);
        vA = cumtrapz(t, aA);
        dA = cumtrapz(t, vA);

        A_A = fft(aA, Nfft);
        V_A = fft(vA, Nfft);
        D_A = fft(dA, Nfft);

        app.ASignals = struct( ...
            'aF', aA, 'v', vA, 'd', dA, ...
            'A', A_A, 'V', V_A, 'D', D_A ...
        );

        % Filter B
        fB = app.FilterB;
        aB = app.applyFilters(a, fB);
        vB = cumtrapz(t, aB);
        dB = cumtrapz(t, vB);

        A_B = fft(aB, Nfft);
        V_B = fft(vB, Nfft);
        D_B = fft(dB, Nfft);

        app.BSignals = struct( ...
            'aF', aB, 'v', vB, 'd', dB, ...
            'A', A_B, 'V', V_B, 'D', D_B ...
        );
    else
        app.ASignals = [];
        app.BSignals = [];
    end
end
