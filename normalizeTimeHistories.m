% ------------------------------------------------------------
% NORMALIZATION
% ------------------------------------------------------------
doNorm = false;
if isprop(app, 'NormalizeCheckBox') && isvalid(app.NormalizeCheckBox)
    doNorm = app.NormalizeCheckBox.Value;
end

aF = sig.aF;
if doNorm && max(abs(aF)) > 0
    aF = aF ./ max(abs(aF));
end
plot(t, aF, 'b');


v = sig.v;
if doNorm && max(abs(v)) > 0
    v = v ./ max(abs(v));
end
plot(t, v, 'b');


d = sig.d;
if doNorm && max(abs(d)) > 0
    d = d ./ max(abs(d));
end
plot(t, d, 'b');


if compareAB
    aA = app.ASignals.aF;
    aB = app.BSignals.aF;

    if doNorm
        if max(abs(aA)) > 0, aA = aA ./ max(abs(aA)); end
        if max(abs(aB)) > 0, aB = aB ./ max(abs(aB)); end
    end

    plot(t, aA, 'r');
    plot(t, aB, 'g');
end


