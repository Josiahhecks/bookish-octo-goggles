-- Local jumpscare + fake ban
local Players      = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

--------------------------------------------------
-- 1) GUI (jumpscare image)
--------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "Screamer"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local img = Instance.new("ImageLabel")
img.Image = "rbxassetid://16635097419"
img.Size = UDim2.new(1,0,1,0)
img.BackgroundTransparency = 1
img.ImageTransparency = 1  -- start invisible
img.Parent = gui

-- flash-in
TweenService:Create(img, TweenInfo.new(0.15), {ImageTransparency = 0}):Play()

--------------------------------------------------
-- 2) Sound (scream)
--------------------------------------------------
local snd = Instance.new("Sound")
snd.SoundId = "rbxassetid://6018028320"
snd.Volume  = 1
snd.Parent  = SoundService
snd:Play()

--------------------------------------------------
-- 3) 1.5-second pause, then fake ban kick
--------------------------------------------------
task.wait(1.5)
player:Kick("You have been banned from this experience.")
