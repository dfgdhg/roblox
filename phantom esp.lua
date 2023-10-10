local container = Instance.new("Folder", gethui());
 
local function createHighlight(character)
    local highlight = Instance.new("Highlight", container);
    highlight.FillColor = BrickColor.new("Bright Green").Color;
    highlight.FillTransparency = 0.1;
    highlight.OutlineTransparency = 1;
    highlight.DepthMode = "AlwaysOnTop";
    highlight.Adornee = character;
 
    character.Destroying:Connect(function()
        highlight:Destroy();
    end);
end
 
for _, team in workspace:WaitForChild("Players"):GetChildren() do
    for _, child in team:GetChildren() do
        createHighlight(child);
    end
    team.ChildAdded:Connect(createHighlight);
end
