function idx = axisToIndex(~, axis)
    switch upper(axis)
        case 'X', idx = 1;
        case 'Y', idx = 2;
        case 'Z', idx = 3;
        otherwise, idx = 1;
    end
end
