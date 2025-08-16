local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

-- Reference or create the RemoteEvent for jumpscare
local JumpscareEvent = ReplicatedStorage:FindFirstChild("JumpscareEvent") or Instance.new("RemoteEvent")
JumpscareEvent.Name = "JumpscareEvent"
JumpscareEvent.Parent = ReplicatedStorage

-- Reference or create the jumpscare sound
local JumpscareSound = Instance.new("Sound")
JumpscareSound.Name = "JumpscareSound"
JumpscareSound.SoundId = "rbxassetid://5853668794" -- Provided sound ID
JumpscareSound.Volume = 1
JumpscareSound.Parent = game.Workspace

-- Get the game creator's username
local creatorName = "Unknown"
local success, gameInfo = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId)
end)
if success and gameInfo then
    local creatorId = gameInfo.Creator.CreatorTargetId
    local creatorInfo = Players:GetNameFromUserIdAsync(creatorId)
    if creatorInfo then
        creatorName = creatorInfo
    end
end

-- Touch detection
script.Parent.Touched:Connect(function(hit)
    local player = Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        -- Play sound and trigger jumpscare
        JumpscareSound:Play()
        JumpscareEvent:FireClient(player)
        
        -- Wait for jumpscare to finish
        wait(2)
        
        -- Kick player with reason including creator's username
        local kickReason = string.format("You have been removed for cheating - %s", creatorName)
        player:Kick(kickReason)
    end
end)
