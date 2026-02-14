function StoreFilterAButtonPushed(app, event)
    app.FilterA.hp    = app.HPField.Value;
    app.FilterA.lp    = app.LPField.Value;
    app.FilterA.order = app.OrderField.Value;
end

function StoreFilterBButtonPushed(app, event)
    app.FilterB.hp    = app.HPField.Value;
    app.FilterB.lp    = app.LPField.Value;
    app.FilterB.order = app.OrderField.Value;
end
