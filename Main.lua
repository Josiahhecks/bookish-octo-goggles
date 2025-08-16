local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService") -- Server-only, fallback for client
local LocalPlayer = Players.LocalPlayer

-- Configuration
local WEBHOOK_URL = "https://discord.com/api/webhooks/1255257736304787486/TkGY3JxSqpvwKCveol6dYHBiRS-qS-TKrPSdZNq661miUX6gIZpJTbCoVT2O_R2U7QC-" -- Replace with your Discord webhook
local JUMPSCARE_SOUND_ID = "rbxassetid://1837829087" -- Public jumpscare sound (screech)
local KICK_REASON = "get banned boy just reported you to the admins by josiah"
local ADMIN_NAME = "roblox" -- Replace with your Roblox username

-- Send Discord webhook (server-side only)
local function sendToDiscord(playerName, action, reason)
    local payload = {
        ["content"] = "LocalPlayer got rekt!",
        ["embeds"] = {{
            ["title"] = "Executor Action",
            ["color"] = 16711680, -- Red color
            ["fields"] = {
                {["name"] = "Action", ["value"] = action, ["inline"] = true},
                {["name"] = "Target", ["value"] = playerName, ["inline"] = true},
                {["name"] = "Admin", ["value"] = ADMIN_NAME, ["inline"] = true},
                {["name"] = "Reason", ["value"] = reason or "N/A", ["inline"] = false},
                {["name"] = "Extra", ["value"] = "Snagged their iPhone, lol!", ["inline"] = false}
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    local success, err = pcall(function()
        HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
    end)
    if not success then
        warn("Webhook failed (likely client-side): " .. err)
        print("Webhook payload (for manual send): " .. HttpService:JSONEncode(payload))
    end
end

-- Jumpscare and kick
local function executeKick()
    -- Play jumpscare sound
    local sound = Instance.new("Sound")
    sound.SoundId = JUMPSCARE_SOUND_ID
    sound.Volume = 1
    sound.Parent = game.Workspace
    sound:Play()
    
    -- Wait for jumpscare, then kick
    wait(2)
    sendToDiscord(LocalPlayer.Name, "Self-Kick", KICK_REASON)
    LocalPlayer:Kick(KICK_REASON)
end

-- Run it
executeKick()
