-- ┌────────────────────────────────────────────┐
-- │  LOCAL JUMPSCARE + SOUND + 1.5 s KICK    │
-- └────────────────────────────────────────────┘
local Players      = game:GetService("Players")
local ContentProv  = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer

--------------------------------------------------
-- 1) Assets (decal + sound)
--------------------------------------------------
local DECAL_ID  = "rbxassetid://752001941"   -- scariest decal
local SOUND_ID  = "rbxassetid://5853668794"  -- jumpscare sound

local gui  = nil
local img  = nil
local snd  = nil

--------------------------------------------------
-- 2) GUARANTEED PRE-LOAD
--------------------------------------------------
local function preLoad()
	-- create invisible objects to preload
	local tempDecal = Instance.new("Decal")
	tempDecal.Texture = DECAL_ID
	local tempSound = Instance.new("Sound")
	tempSound.SoundId = SOUND_ID

	ContentProv:PreloadAsync({tempDecal, tempSound})

	tempDecal:Destroy()
	tempSound:Destroy()
end

--------------------------------------------------
-- 3) BUILD GUI & SOUND (but keep hidden)
--------------------------------------------------
local function buildAssets()
	gui = Instance.new("ScreenGui")
	gui.IgnoreGuiInset = true
	gui.ResetOnSpawn   = false
	gui.Parent = player:WaitForChild("PlayerGui")

	img = Instance.new("ImageLabel")
	img.Image = DECAL_ID
	img.Size = UDim2.new(1, 0, 1, 0)
	img.BackgroundTransparency = 1
	img.ImageTransparency = 1
	img.Parent = gui

	snd = Instance.new("Sound")
	snd.SoundId = SOUND_ID
	snd.Volume  = 1
	snd.Parent  = SoundService
end

--------------------------------------------------
-- 4) FIRE EVERYTHING AT ONCE
--------------------------------------------------
local function trigger()
	img.ImageTransparency = 0      -- show image instantly
	snd:Play()                     -- play sound instantly
end

--------------------------------------------------
-- 5) MAIN FLOW
--------------------------------------------------
preLoad()        -- 1) guarantee assets are ready
buildAssets()    -- 2) create hidden gui & sound
trigger()        -- 3) simultaneous jumpscare
task.wait(1.5)   -- 4) 1.5-second pause
player:Kick("You have been banned from this experience.")
