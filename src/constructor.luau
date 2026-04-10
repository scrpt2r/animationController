--[[
	******************************************************************************
	* @file		: .../src/libs/constructor.lua
	* @author	: Scrpt2r
	* @date		: April 09 2026
	* @lastEdit	: April 11 2026 02:45
	* @brief	: Animation controller for any model / character.
	* @version	: 0.6.5
	******************************************************************************
	* @attention
	*
	* Copyright © 2026 Axon Corporation.
	* All rights reserved.
	*
	* This software is licensed under terms that can be found in the LICENSE file
	* in the root directory of this software component.
	* If no LICENSE file comes with this software, it is provided AS-IS.
	*
	******************************************************************************
--]]

--// Libs
local types = require(script.Parent.global.types)

--// Types
export type _animName = types.animName
type animName = _animName

export type _animPriority = types.animPriority
type animPriority = _animPriority

export type _trackConfig = types.trackConfig
type trackConfig = _trackConfig

export type _queueEntry = types.queueEntry
type queueEntry = _queueEntry

export type _animationControllerType = types.animationControllerType
type animationControllerType = _animationControllerType

--// Constants
local DEFAULT_CONFIG = {
	fadeIn = 0.1,
	fadeOut = 0.15,
	speed = 1,
	looped = false,
	priority = "Action",
} :: trackConfig

--// Functions
function mergeConfig(config: trackConfig?): trackConfig
	if not config then
		return DEFAULT_CONFIG
	end

	return {
		fadeIn = config.fadeIn or DEFAULT_CONFIG.fadeIn,
		fadeOut = config.fadeOut or DEFAULT_CONFIG.fadeOut,
		speed = config.speed or DEFAULT_CONFIG.speed,
		looped = if config.looped ~= nil then config.looped else DEFAULT_CONFIG.looped,
		priority = config.priority or DEFAULT_CONFIG.priority,
	}
end

--// Lib Decleration
local animationController = {}
animationController.__index = animationController :: any

--// Lib Functions
function animationController.new(model: Model): animationControllerType
	local humanoid = model:WaitForChild("Humanoid")
	if not humanoid then
		return nil :: any
	end

	local animator = humanoid:WaitForChild("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local tracks = {} :: { [string]: AnimationTrack }
	local animFolder = model:WaitForChild("Animations") :: Folder

	if animFolder then
		for _, child in animFolder:GetChildren() do
			local ok, result = pcall(function()
				return (animator :: Animator):LoadAnimation(child :: Animation)
			end)

			if ok and result then
				tracks[child.Name] = result :: AnimationTrack
			end
		end
	end

	local self = setmetatable({
		_animator = animator :: Animator,
		_tracks = tracks,
		_current = nil :: animName?,
		_previous = nil :: animName?,
		_model = model,
		_queue = {} :: { queueEntry },
		_isLocked = false,
		_connections = {} :: { RBXScriptConnection },
	}, animationController)

	return self :: any
end

function animationController:getTrack(name: animName): AnimationTrack?
	return self._tracks[name]
end

function animationController:getCurrent(): animName?
	return self._current
end

function animationController:getPrevious(): animName?
	return self._previous
end

function animationController:isPlaying(name: animName): boolean
	local track = self._tracks[name]
	return track ~= nil and track.IsPlaying
end

function animationController:getProgress(name: animName): number
	local track = self._tracks[name]

	if not track or not track.IsPlaying then
		return 0
	end

	local length = track.Length
	if length == 0 then
		return 0
	end

	return math.clamp(track.TimePosition / length, 0, 1)
end

function animationController:_applyTrackSettings(track: AnimationTrack, config: trackConfig)
	track:AdjustSpeed(config.speed)

	if config.looped ~= nil then
		track.Looped = config.looped
	end

	if config.priority then
		local priorityMap = {
			Action4 = Enum.AnimationPriority.Action4,
			Action3 = Enum.AnimationPriority.Action3,
			Action2 = Enum.AnimationPriority.Action2,
			Action = Enum.AnimationPriority.Action,
			Movement = Enum.AnimationPriority.Movement,
			Idle = Enum.AnimationPriority.Idle,
		}

		local p = priorityMap[config.priority]
		if p then
			track.Priority = p
		end
	end
end

function animationController:_processQueue()
	if #self._queue == 0 or self._isLocked then
		return
	end

	local next = table.remove(self._queue, 1)

	if next.actionType == "play" then
		self:play(next.name, next.config)
	elseif next.actionType == "playLocked" then
		self:playLocked(next.name, next.config, next.callback)
	else
		self:playOnce(next.name, next.config, next.callback)
	end
end

function animationController:play(name: animName, config: trackConfig?): AnimationTrack?
	if self._isLocked then
		table.insert(self._queue, { name = name, config = config, actionType = "playOnce" })
		return nil :: any
	end

	local track = self._tracks[name]
	if not track then
		print("Track cannot be founded")
		return nil :: any
	end

	if track.IsPlaying then
		print("Cannot play becouse an animation is already playing.")
		return track
	end

	local cfg = mergeConfig(config)
	self:_applyTrackSettings(track, cfg)

	if self._current and self._current ~= name then
		local prev = self._tracks[self._current]

		if prev and prev.IsPlaying and prev.Looped then
			prev:Stop(cfg.fadeOut)
		end
	end

	track:Play(cfg.fadeIn)
	self._previous = self._current
	self._current = name

	return track
end

function animationController:playOnce(name: animName, config: trackConfig?, callback: (() -> ())?): AnimationTrack?
	local track = self._tracks[name]
	if not track then
		return nil :: any
	end

	local cfg = mergeConfig(config)
	cfg.looped = false

	self:_applyTrackSettings(track, cfg)

	if self._current and self._current ~= name then
		local prev = self._tracks[self._current]

		if prev and prev.IsPlaying and not prev.Looped then
			prev:Stop(cfg.fadeOut)
		end
	end

	track:Play(cfg.fadeIn)
	self._previous = self._current
	self._current = name

	local conn: RBXScriptConnection
	conn = track.Stopped:Connect(function()
		conn:Disconnect()

		if self._current == name then
			self._current = nil
		end

		if callback then
			callback()
		end

		self:_processQueue()
	end)

	table.insert(self._connections, conn)
	return track
end

function animationController:playLocked(name: animName, config: trackConfig?, callback: (() -> ())?): AnimationTrack?
	self._isLocked = true

	return self:playOnce(name, config, function()
		self._isLocked = false

		if callback then
			callback()
		end

		self:_processQueue()
	end)
end

function animationController:queue(name: animName, config: trackConfig?, callback: (() -> ())?)
	table.insert(self._queue, {
		name = name,
		config = config,
		callback = callback,
		actionType = "playOnce",
	})

	self:_processQueue()
end

function animationController:stop(name: animName?, fadeTime: number?)
	local fade = fadeTime or DEFAULT_CONFIG.fadeOut

	if name then
		local track = self._tracks[name]

		if track and track.IsPlaying then
			track:Stop(fade)
		end

		if self._current == name then
			self._current = self._previous
		end
	else
		if self._current then
			local track = self._tracks[self._current]

			if track and track.IsPlaying then
				track:Stop(fade)
			end

			self._previous = self._current
			self._current = nil
		end
	end
end

function animationController:stopAll()
	for _, track in self._tracks do
		if track.IsPlaying then
			track:Stop(DEFAULT_CONFIG.fadeOut)
		end
	end

	self._current = nil
	self._previous = nil
	table.clear(self._queue)
	self._isLocked = false
end

function animationController:setSpeed(name: animName, speed: number)
	local track = self._tracks[name]

	if track then
		track:AdjustSpeed(speed)
	end
end

function animationController:setWeight(name: animName, weight: number, fadeTime: number?)
	local track = self._tracks[name]

	if track then
		track:AdjustWeight(weight, fadeTime or DEFAULT_CONFIG.fadeIn)
	end
end

function animationController:destroy()
	self:stopAll()

	for _, conn in self._connections do
		conn:Disconnect()
	end

	table.clear(self._connections)

	for name, track in self._tracks do
		track:Destroy()
		self._tracks[name] = nil :: any
	end
end

return animationController
