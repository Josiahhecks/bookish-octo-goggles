--// Services
local Players      = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

--------------------------------------------------
-- 1)  Create GUI & sound up-front, but keep hidden
--------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn   = false
gui.Parent = player:WaitForChild("PlayerGui")

local img = Instance.new("ImageLabel")
img.Image = "rbxassetid://752001941"
img.Size = UDim2.new(1, 0, 1, 0)
img.BackgroundTransparency = 1
img.ImageTransparency = 1
img.Parent = gui

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://5853668794"
sound.Volume  = 1
sound.Parent  = SoundService

--------------------------------------------------
-- 2)  FIRE EVERYTHING AT ONCE
--------------------------------------------------
-- Show decal instantly
img.ImageTransparency = 0
-- Play sound instantly
sound:Play()

--------------------------------------------------
-- 3)  KICK AFTER 1.5 SECONDS
--------------------------------------------------
task.wait(1.5)
player:Kick("You have been banned from this experience.")
