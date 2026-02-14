function updateFFT(app)

    parent = app.FFTPanel;
    delete(parent.Children);

    tl = tiledlayout(parent,3,1,'TileSpacing','compact','Padding','compact');

    showA = app.ShowAccelCheckBox.Value;
    showV = app.ShowVelocityCheckBox.Value;
    showD = app.ShowDisplacementCheckBox.Value;

    compareMode = app.CompareFiltersCheckBox.Value && ...
                  ~isempty(app.ASignals) && ~isempty(app.BSignals);

    fvec = app.curSignals.fvec;

    % ---------------- Accel FFT ----------------
    axA = nexttile(tl);
    if showA
        if ~compareMode
            loglog(axA, fvec, abs(app.curSignals.A), 'k');
            title(axA,'Acceleration Spectrum');
            mag = abs(app.curSignals.A);
            app.annotatePeaks(axA, fvec, mag, 3);

        else
            loglog(axA, fvec, abs(app.ASignals.A), 'k', ...
                        fvec, abs(app.BSignals.A), 'r');
            title(axA,'Acceleration Spectrum (A vs B)');
            legend(axA,{'A','B'});
            magA = abs(app.ASignals.A);
            magB = abs(app.BSignals.A);
            app.annotatePeaks(axA, fvec, magA, 2);
            app.annotatePeaks(axA, fvec, magB, 2);
end

        end
    end
    ylabel(axA,'|A(f)|');
    app.applyFFTScale(axA);

    % ---------------- Velocity FFT ----------------
    axV = nexttile(tl);
    if showV
        if ~compareMode
            loglog(axV, fvec, abs(app.curSignals.V), 'b');
            title(axV,'Velocity Spectrum');
            mag = abs(app.curSignals.V);
            app.annotatePeaks(axV, fvec, mag, 3);            
        else
            loglog(axV, fvec, abs(app.ASignals.V), 'b', ...
                        fvec, abs(app.BSignals.V), 'm');
            title(axV,'Velocity Spectrum (A vs B)');
            legend(axV,{'A','B'});
            magA = abs(app.ASignals.V);
            magB = abs(app.BSignals.V);
            app.annotatePeaks(axV, fvec, magA, 2);
            app.annotatePeaks(axV, fvec, magB, 2);            
        end
    end
    ylabel(axV,'|V(f)|');
    app.applyFFTScale(axV);

    % ---------------- Displacement FFT ----------------
    axD = nexttile(tl);
    if showD
        if ~compareMode
            loglog(axD, fvec, abs(app.curSignals.D), 'r');
            title(axD,'Displacement Spectrum');
            mag = abs(app.curSignals.D);
            app.annotatePeaks(axD, fvec, mag, 3);                    
        else
            loglog(axD, fvec, abs(app.ASignals.D), 'r', ...
                        fvec, abs(app.BSignals.D), 'c');
            title(axD,'Displacement Spectrum (A vs B)');
            legend(axD,{'A','B'});
            magA = abs(app.ASignals.D);
            magB = abs(app.BSignals.D);
            app.annotatePeaks(axD, fvec, magA, 2);
            app.annotatePeaks(axD, fvec, magB, 2);               
        end
    end
    ylabel(axD,'|D(f)|');
    xlabel(axD,'Frequency (Hz)');
    app.applyFFTScale(axD);

    linkaxes([axA axV axD],'x');
    enableDefaultInteractivity(axA);
    enableDefaultInteractivity(axV);
    enableDefaultInteractivity(axD);

end
