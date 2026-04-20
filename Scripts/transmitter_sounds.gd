extends AudioStreamPlayer

@export var fireInstructionSound: AudioStream = null
const PITCH_MIN: float = 0.8
const PITCH_MAX: float = 1.2

func play_sound(sound: AudioStream, randomize_pitch: bool=false) -> bool:
	if sound == null: return false
	
	stream = sound
	if randomize_pitch:
		pitch_scale = randf_range(PITCH_MIN, PITCH_MAX)
	else:
		pitch_scale = 1.0
	play()
	return true


func _on_transmitter_on_instruction_fire(direction: String) -> void:
	play_sound(fireInstructionSound, true)
