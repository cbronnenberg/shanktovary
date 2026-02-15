function AccelHeaderButtonPushed(app, event)
    if app.AccelContentPanel.Visible
        app.AccelContentPanel.Visible = 'off';
        app.AccelHeaderButton.Text = "►  Accelerometers";
    else
        app.AccelContentPanel.Visible = 'on';
        app.AccelHeaderButton.Text = "▼  Accelerometers";
    end
end
