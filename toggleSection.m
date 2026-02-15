function toggleSection(app, thisIndex)
    % Handles expand/collapse for one section and collapses all others

    % Extract handles for THIS section
    contentPanel = app.SectionContentPanels{thisIndex};
    headerButton = app.SectionHeaderButtons{thisIndex};
    rowIndex     = app.SectionRowIndices{thisIndex};

    % Force layout to compute header height
    drawnow;
    headerHeight = headerButton.Position(4);

    if strcmp(contentPanel.Visible,'on')
        % --- COLLAPSE THIS SECTION ---
        contentPanel.Visible = 'off';
        headerButton.Text = strrep(headerButton.Text, "▼", "►");

        % Force row to header height
        app.LeftGrid.RowHeight{rowIndex} = headerHeight;

    else
        % --- EXPAND THIS SECTION ---
        contentPanel.Visible = 'on';
        headerButton.Text = strrep(headerButton.Text, "►", "▼");

        % Let MATLAB compute natural height
        app.LeftGrid.RowHeight{rowIndex} = 'fit';

        % --- COLLAPSE ALL OTHER SECTIONS ---
        for k = 1:numel(app.SectionContentPanels)
            if k ~= thisIndex
                otherPanel = app.SectionContentPanels{k};
                otherHeader = app.SectionHeaderButtons{k};
                otherRow = app.SectionRowIndices{k};

                % Collapse
                otherPanel.Visible = 'off';
                otherHeader.Text = strrep(otherHeader.Text, "▼", "►");

                % Force row to header height
                drawnow;
                h = otherHeader.Position(4);
                app.LeftGrid.RowHeight{otherRow} = h;
            end
        end
    end
end
