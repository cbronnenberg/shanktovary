function da = computeRelativeAcceleration(app, a1, a2, axis1, axis2)
    switch app.RelativeModeDropDown.Value
        case 'Pure Difference'
            da = a1 - a2;

        case 'Axis-Aware Difference'
            % axis1 and axis2 are 'X','Y','Z'
            idx1 = app.axisToIndex(axis1);
            idx2 = app.axisToIndex(axis2);
            da = a1(:,idx1) - a2(:,idx2);

        case 'FRF-Based (coming soon)'
            da = a1 - a2;
    end
end
