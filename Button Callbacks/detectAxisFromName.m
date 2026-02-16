function axis = detectAxisFromName(name)
% DETECTAXISFROMNAME
% Returns 'X', 'Y', or 'Z' if exactly one is found in the name.
% Otherwise defaults to 'Z'.

    letters = upper(char(name));

    foundX = contains(letters, 'X');
    foundY = contains(letters, 'Y');
    foundZ = contains(letters, 'Z');

    count = foundX + foundY + foundZ;

    if count == 1
        if foundX, axis = 'X'; return; end
        if foundY, axis = 'Y'; return; end
        if foundZ, axis = 'Z'; return; end
    end

    % Default
    axis = 'Z';

end
