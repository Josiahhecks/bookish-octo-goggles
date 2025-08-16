--// Services
local Players       = game:GetService("Players")
local SoundService  = game:GetService("SoundService")
local TweenService  = game:GetService("TweenService")

local player = Players.LocalPlayer

------------------------------------------------------------------
-- 1)  FULL-SCREEN JUMPSCARE GUI (scariest decal)
------------------------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn   = false
gui.Parent = player:WaitForChild("PlayerGui")

local img = Instance.new("ImageLabel")
img.Image = "rbxassetid://752001941"  -- SCARIEST decal
img.Size = UDim2.new(1, 0, 1, 0)
img.BackgroundTransparency = 1
img.ImageTransparency = 1
img.Parent = gui

-- Flash in instantly
TweenService:Create(img, TweenInfo.new(0.15), {ImageTransparency = 0}):Play()

------------------------------------------------------------------
-- 2)  JUMPSCARE SOUND (2D, local-only)
------------------------------------------------------------------
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://5853668794"
sound.Volume  = 1
sound.Parent  = SoundService
sound:Play()

------------------------------------------------------------------
-- 3)  FAKE BAN & KICK
------------------------------------------------------------------
-- Wait for the sound to finish, then kick
task.wait(sound.TimeLength + 0.2)
player:Kick("You have been banned from this experience.")
