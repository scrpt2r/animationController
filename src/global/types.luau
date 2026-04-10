local types = {}

export type animName = string

export type animPriority = "Action4" | "Action3" | "Action2" | "Action" | "Movement" | "Idle"

export type trackConfig = {
	fadeIn: number,
	fadeOut: number,
	speed: number,
	looped: boolean?,
	priority: animPriority?,
}

export type queueEntry = {
	name: string,
	config: trackConfig?,
	callback: (() -> ())?,
	actionType: string?,
}

export type animationControllerType = {
	_animator: Animator,
	_tracks: { [string]: AnimationTrack },
	_current: animName?,
	_previous: animName?,
	_model: Model,
	_queue: { queueEntry },
	_isLocked: boolean,
	_connections: { RBXScriptConnection },

	getTrack: (self: animationControllerType, name: animName) -> AnimationTrack?,
	getCurrent: (self: animationControllerType) -> animName?,
	getPrevious: (self: animationControllerType) -> animName?,
	isPlaying: (self: animationControllerType, name: animName) -> boolean,
	getProgress: (self: animationControllerType, name: animName) -> number,

	play: (self: animationControllerType, name: animName, config: trackConfig?) -> AnimationTrack?,
	playOnce: (
		self: animationControllerType,
		name: animName,
		config: trackConfig?,
		callback: (() -> ())?
	) -> AnimationTrack?,
	playLocked: (
		self: animationControllerType,
		name: animName,
		config: trackConfig?,
		callback: (() -> ())?
	) -> AnimationTrack?,
	queue: (self: animationControllerType, name: animName, config: trackConfig?, callback: (() -> ())?) -> (),
	stop: (self: animationControllerType, name: animName?, fadeTime: number?) -> (),
	stopAll: (self: animationControllerType) -> (),
	setSpeed: (self: animationControllerType, name: animName, speed: number) -> (),
	setWeight: (self: animationControllerType, name: animName, weight: number, fadeTime: number?) -> (),

	destroy: (self: animationControllerType) -> (),
}

return types
