extends AudioStreamPlayer

@export var fireInstructionSound: AudioStream = null

func play_sound(sound: AudioStream) -> bool:
	if sound == null: return false
	
	stream = sound
	play()
	return true


func _on_transmitter_on_instruction_fire(direction: String) -> void:
	play_sound(fireInstructionSound)
