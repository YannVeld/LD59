extends Node2D

var direction: String
var mouse_position

var SignalPacketScene = preload("res://Scenes/SignalPacket.tscn")
var SignalPacketInstance

@onready var dish = $"./DishSprite"
@onready var sound_player: SoundPlayer = $SoundPlayer

@export
var disable_aimguide = false

var transmitter_ready = false
var last_input_device = "keyboard_mouse"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if disable_aimguide:
		$AimGuide.queue_free()

		
func _input(event) -> void:
	if (event is InputEventJoypadButton) or (event is InputEventJoypadMotion):
		last_input_device = "controller"
	elif (event is InputEventMouseMotion) \
		or (event is InputEventMouseButton) \
		or (event is InputEventKey):
		last_input_device = "keyboard_mouse"
		
	
	if not transmitter_ready:
		return
		
	if (event is InputEventKey) or (event is InputEventJoypadButton):
		direction = "null" 
		# Send signal packet
		if Input.is_action_pressed("move_down"):
			direction = 'down' 
		if Input.is_action_pressed("move_up"):
			direction = 'up' 
		if Input.is_action_pressed("move_left"):
			direction = 'left' 
		if Input.is_action_pressed("move_right"):
			direction = 'right'
		
		if direction != 'null': 
			SignalPacketInstance = SignalPacketScene.instantiate()
			SignalPacketInstance.instruction = direction
			
			var _dir = Vector2.RIGHT
			if last_input_device == "controller":
				_dir = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down").normalized()
			else:
				mouse_position = get_viewport().get_mouse_position()
				_dir = ((mouse_position - dish.global_position).normalized())
			
			SignalPacketInstance.direction = _dir
			SignalPacketInstance.position = dish.global_position
			SignalPacketInstance.add_to_group("Signal Packets")
			$"../SignalPackets".add_child(SignalPacketInstance)
			sound_player.play_sound(SoundPlayer.Sounds.TRANSMITTER_FIRE)
	return 
	


func _on_tower_landing_landing_animation_finished() -> void:
	transmitter_ready = true
