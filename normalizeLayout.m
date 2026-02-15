function normalizeLayout(app, root)
    % Recursively normalize padding, spacing, and limits for all containers

    if isa(root, 'matlab.ui.container.GridLayout')
        root.Padding = [0 0 0 0];
        root.RowSpacing = 0;
        root.ColumnSpacing = 0;
        root.RowHeight = root.RowHeight;   % forces recompute
        root.ColumnWidth = root.ColumnWidth;
        root.Scrollable = 'off';           % grids should never scroll
        root.HeightLimits = [0 Inf];
        root.WidthLimits = [0 Inf];
    end

    if isa(root, 'matlab.ui.container.Panel')
        root.Padding = [0 0 0 0];
        root.Scrollable = root.Scrollable; % leave scrollable panels alone
        root.HeightLimits = [0 Inf];
        root.WidthLimits = [0 Inf];
    end

    % Recurse into children
    kids = root.Children;
    for k = 1:numel(kids)
        normalizeLayout(app, kids(k));
    end
end
