-- ┌────────────────────────────────────────────┐
-- │  LOCAL JUMPSCARE + SOUND + 1.5 s KICK    │
-- │  100 % CLIENT-SIDE – put in LocalScript  │
-- └────────────────────────────────────────────┘
local Players      = game:GetService("Players")
local ContentProv  = game:GetService("ContentProvider")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

--------------------------------------------------
-- 1) GUARANTEED PRE-LOAD (decal + sound)
--------------------------------------------------
local DECAL_ID = "rbxassetid://5863570394"   -- new scary decal
local SOUND_ID = "rbxassetid://5853668794"   -- jumpscare sound

local tempDecal = Instance.new("Decal")
tempDecal.Texture = DECAL_ID
local tempSound = Instance.new("Sound")
tempSound.SoundId = SOUND_ID
ContentProv:PreloadAsync({tempDecal, tempSound})
tempDecal:Destroy()
tempSound:Destroy()

--------------------------------------------------
-- 2) BUILD GUI & SOUND (hidden for now)
--------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn   = false
gui.Parent = player:WaitForChild("PlayerGui")

local img = Instance.new("ImageLabel")
img.Image = DECAL_ID
img.Size = UDim2.new(1, 0, 1, 0)
img.BackgroundTransparency = 1
img.ImageTransparency = 1   -- start invisible
img.Parent = gui

local snd = Instance.new("Sound")
snd.SoundId = SOUND_ID
snd.Volume  = 1
snd.Parent  = SoundService

--------------------------------------------------
-- 3) FIRE EVERYTHING AT ONCE
--------------------------------------------------
img.ImageTransparency = 0   -- reveal instantly
snd:Play()                  -- play instantly

--------------------------------------------------
-- 4) 1.5-second pause, then kick
--------------------------------------------------
task.wait(1.5)
player:Kick("You have been banned from this experience.")
