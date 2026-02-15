function toggleSection(app, contentPanel, headerButton, rowIndex)
    if strcmp(contentPanel.Visible,'on')
        % Collapse
        contentPanel.Visible = 'off';
        headerButton.Text = strrep(headerButton.Text, "▼", "►");

        % Shrink the row
        app.LeftGrid.RowHeight{rowIndex} = 'fit';

    else
        % Expand
        contentPanel.Visible = 'on';
        headerButton.Text = strrep(headerButton.Text, "►", "▼");

        % Let the row auto-size to content
        app.LeftGrid.RowHeight{rowIndex} = 'fit';
    end
end

% Usage
% app.toggleSection(app.AccelContentPanel, app.AccelHeaderButton, 1)
