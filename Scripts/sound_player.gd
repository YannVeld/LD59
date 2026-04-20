class_name SoundPlayer extends AudioStreamPlayer

enum Sounds {ROBOT_COLLECT, ROBOT_BUMP, ROBOT_RECEIVE,
			 ROBOT_TAKEOFF,
			 TRANSMITTER_FIRE,
			 PACKET_REFLECTED, PACKET_BLOCKED}
const _sound_dict: Dictionary[Sounds, AudioStream] = {
	Sounds.ROBOT_COLLECT: preload("res://Sounds/Pickup.wav"),
	Sounds.ROBOT_BUMP: preload("res://Sounds/Bump.wav"),
	Sounds.ROBOT_RECEIVE: preload("res://Sounds/Pip.wav"),
	Sounds.ROBOT_TAKEOFF: preload("res://Sounds/Takeoff.wav"),
	Sounds.TRANSMITTER_FIRE: preload("res://Sounds/Shoot.wav"),
	Sounds.PACKET_REFLECTED: preload("res://Sounds/Reflect.wav"),
	Sounds.PACKET_BLOCKED: preload("res://Sounds/Blocked.wav")
}
	
const PITCH_MIN: float = 0.8
const PITCH_MAX: float = 1.2
	
func play_sound_stream(sound_stream: AudioStream, randomize_pitch: bool=false, delay: float=0.0, live_and_destroy: bool=false) -> void:
	if sound_stream == null: return
	
	if live_and_destroy:
		self.reparent(get_tree().root)
	
	if delay > 0.0:
		await get_tree().create_timer(delay).timeout
	
	stream = sound_stream
	if randomize_pitch:
		pitch_scale = randf_range(PITCH_MIN, PITCH_MAX)
	else:
		pitch_scale = 1.0
	play()
	
	if live_and_destroy:
		await finished 
		queue_free()
	

func play_sound(sound: Sounds, randomize_pitch: bool=false, delay: float=0.0, live_and_destroy: bool=false) -> void:
	if not sound in _sound_dict: return
	
	play_sound_stream(_sound_dict[sound], randomize_pitch, delay, live_and_destroy)
