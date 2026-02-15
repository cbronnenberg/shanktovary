function updateTimeDetailTab(app, TH)

    parent = app.TimeDetailPanel;
    delete(parent.Children);

    tl = tiledlayout(parent, 3, 2, ...
        'TileSpacing','compact', ...
        'Padding','compact');

    axTH_a  = nexttile(tl,1);
    axRMS_a = nexttile(tl,2);
    axTH_v  = nexttile(tl,3);
    axRMS_v = nexttile(tl,4);
    axTH_d  = nexttile(tl,5);
    axRMS_d = nexttile(tl,6);

    t = app.sig.t;   % or app.rel.t depending on mode

    % === Time histories ===
    plot(axTH_a, t, TH.a, 'LineWidth',1.1);
    title(axTH_a,'Acceleration Time History');
    ylabel(axTH_a,'a');
    grid(axTH_a,'on');
    app.annotateMetadata(axTH_a);

    plot(axTH_v, t, TH.v, 'LineWidth',1.1);
    title(axTH_v,'Velocity Time History');
    ylabel(axTH_v,'v');
    grid(axTH_v,'on');
    app.annotateMetadata(axTH_v);

    plot(axTH_d, t, TH.d, 'LineWidth',1.1);
    title(axTH_d,'Displacement Time History');
    ylabel(axTH_d,'d');
    xlabel(axTH_d,'Time (s)');
    grid(axTH_d,'on');
    app.annotateMetadata(axTH_d);

    % === Running + Cumulative RMS ===
    plot(axRMS_a, t, TH.rr_a, 'LineWidth',1.1);
    hold(axRMS_a,'on');
    plot(axRMS_a, t, TH.cum_a, 'LineWidth',1.1,'LineStyle','--');
    title(axRMS_a,'Running & Cumulative RMS (Accel)');
    legend(axRMS_a,{'Running','Cumulative'});
    grid(axRMS_a,'on');

    plot(axRMS_v, t, TH.rr_v, 'LineWidth',1.1);
    hold(axRMS_v,'on');
    plot(axRMS_v, t, TH.cum_v, 'LineWidth',1.1,'LineStyle','--');
    title(axRMS_v,'Running & Cumulative RMS (Vel)');
    legend(axRMS_v,{'Running','Cumulative'});
    grid(axRMS_v,'on');

    plot(axRMS_d, t, TH.rr_d, 'LineWidth',1.1);
    hold(axRMS_d,'on');
    plot(axRMS_d, t, TH.cum_d, 'LineWidth',1.1,'LineStyle','--');
    title(axRMS_d,'Running & Cumulative RMS (Disp)');
    legend(axRMS_d,{'Running','Cumulative'});
    xlabel(axRMS_d,'Time (s)');
    grid(axRMS_d,'on');

    % Store axes for export
    app.axTH_a  = axTH_a;
    app.axRMS_a = axRMS_a;
    app.axTH_v  = axTH_v;
    app.axRMS_v = axRMS_v;
    app.axTH_d  = axTH_d;
    app.axRMS_d = axRMS_d;
end
