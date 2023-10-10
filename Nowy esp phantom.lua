local container = Instance.new("Folder", gethui())

local function createHighlight(character)
    local highlight = Instance.new("Highlight", container)
    highlight.FillColor = BrickColor.new("Bright blue").Color
    highlight.FillTransparency = 0.1
    highlight.OutlineTransparency = 1
    highlight.DepthMode = "AlwaysOnTop"
    highlight.Adornee = character

    character.Destroying:Connect(function()
        highlight:Destroy()
    end)
end

local function addPlayer(player)
    for _, child in pairs(player:GetChildren()) do
        if child:IsA("Model") then
            createHighlight(child)
        end
    end
end

local function onPlayerAdded(player)
    print(player.Name .. " dołączył na serwer.")
    
    player.CharacterAdded:Connect(function(character)
        createHighlight(character)
    end)

    player.CharacterRemoving:Connect(function(character)
        for _, highlight in pairs(container:GetChildren()) do
            if highlight.Adornee == character then
                highlight:Destroy()
            end
        end
    end)

    addPlayer(player)
end

-- Przeszukiwanie istniejących graczy
for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    onPlayerAdded(player)
end

-- Nasłuchiwanie na nowych graczy
game:GetService("Players").PlayerAdded:Connect(onPlayerAdded)

-- Drugi fragment skryptu
for _, team in workspace:WaitForChild("Players"):GetChildren() do
    for _, child in team:GetChildren() do
        createHighlight(child)
    end
    team.ChildAdded:Connect(createHighlight)
end
