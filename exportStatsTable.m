function exportStatsTable(app)
    if isempty(app.BatchStatsTable)
        return;
    end

    prefix = app.FileNamePrefixField.Value;
    suffix = app.FileNameSuffixField.Value;

    fname = sprintf('%s_BatchStats_%s.csv', prefix, suffix);
    writetable(app.BatchStatsTable, fname);
end
