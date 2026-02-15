function toggleSection(app, contentPanel, headerButton)
    if strcmp(contentPanel.Visible,'on')
        contentPanel.Visible = 'off';
        headerButton.Text = strrep(headerButton.Text, "▼", "►");
    else
        contentPanel.Visible = 'on';
        headerButton.Text = strrep(headerButton.Text, "►", "▼");
    end
end
