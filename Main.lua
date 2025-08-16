local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local ContentProvider = game:GetService("ContentProvider")

-- Reference or create the RemoteEvent
local JumpscareEvent = ReplicatedStorage:FindFirstChild("JumpscareEvent") or Instance.new("RemoteEvent")
JumpscareEvent.Name = "JumpscareEvent"
JumpscareEvent.Parent = ReplicatedStorage

-- Create and configure the jumpscare sound
local JumpscareSound = Instance.new("Sound")
JumpscareSound.Name = "JumpscareSound"
JumpscareSound.SoundId = "rbxassetid://5853668794"
JumpscareSound.Volume = 1
JumpscareSound.Parent = game.Workspace

-- Preload the sound to avoid delays
local success, errorMsg = pcall(function()
    ContentProvider:PreloadAsync({JumpscareSound})
end)
if not success then
    warn("Failed to preload sound: " .. errorMsg)
end

-- Get the game creator's username
local creatorName = "Unknown"
local success, gameInfo = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId)
end)
if success and gameInfo and gameInfo.Creator then
    local creatorId = gameInfo.Creator.CreatorTargetId
    local creatorInfo = pcall(function()
        return Players:GetNameFromUserIdAsync(creatorId)
    end)
    if creatorInfo[1] then
        creatorName = creatorInfo[2]
    end
end

-- Touch detection
script.Parent.Touched:Connect(function(hit)
    local player = Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        -- Trigger jumpscare and play sound
        pcall(function()
            JumpscareSound:Play()
            JumpscareEvent:FireClient(player)
        end)
        
        -- Wait for jumpscare to complete
        wait(1.5) -- Reduced to minimize lag
        
        -- Kick player
        local kickReason = string.format("You have been removed for cheating - %s", creatorName)
        pcall(function()
            player:Kick(kickReason)
        end)
    end
end)
