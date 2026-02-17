function y = applyTaper(app, x)
%APPLYTAPER  Apply a Hann taper to the ends of the signal.

    N = length(x);
    w = hann(round(0.05*N));   % 5% taper on each side

    y = x;
    y(1:length(w))       = y(1:length(w))       .* w;
    y(end-length(w)+1:end) = y(end-length(w)+1:end) .* w;
end
