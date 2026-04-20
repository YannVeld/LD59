extends Node2D

var direction: String
var mouse_position

var SignalPacketScene = preload("res://Scenes/SignalPacket.tscn")
var SignalPacketInstance

@onready var dish = $"./DishSprite"

@export
var disable_aimguide = false

var transmitter_ready = false

signal on_instruction_fire(direction: String)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if disable_aimguide:
		$AimGuide.queue_free()

		
func _input(event) -> void:
	if not transmitter_ready:
		return
		
	if event is InputEventKey:
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
			mouse_position = get_viewport().get_mouse_position()
			SignalPacketInstance = SignalPacketScene.instantiate()
			SignalPacketInstance.instruction = direction
			SignalPacketInstance.direction = ((mouse_position - dish.global_position).normalized())
			SignalPacketInstance.position = dish.global_position
			SignalPacketInstance.add_to_group("Signal Packets")
			$"../SignalPackets".add_child(SignalPacketInstance)
			on_instruction_fire.emit(direction)
	return 
	


func _on_tower_landing_landing_animation_finished() -> void:
	transmitter_ready = true
