class_name RobotSounds extends AudioStreamPlayer

enum Sounds {COLLECT, BUMP, RECEIVE}
@export var _sound_dict: Dictionary[Sounds, AudioStream] = {}

func play_sound(sound: Sounds) -> bool:
	if not sound in _sound_dict:
		return false
	
	stream = _sound_dict[sound]
	play()
	return true




func _on_robot_bumped_wall() -> void:
	play_sound(Sounds.BUMP)


func _on_robot_item_collected() -> void:
	await get_tree().create_timer(0.5).timeout
	play_sound(Sounds.COLLECT)


func _on_robot_received_instruction() -> void:
	play_sound(Sounds.RECEIVE)
