function out = exportCurrentResults(app)
    out = struct();
    out.fs = app.fs;
    out.t  = app.t;
    out.a  = app.a;

    out.cur = app.curSignals;
    out.A   = app.ASignals;
    out.B   = app.BSignals;

    out.bands = app.DominantBandsTable;
end
