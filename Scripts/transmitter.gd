extends Node2D

var direction: String
var mouse_position

var SignalPacketScene = preload("res://Scenes/SignalPacket.tscn")
var SignalPacketInstance

@onready var dish = $"./DishSprite"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event) -> void:
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
			$"../SignalPackets".add_child(SignalPacketInstance)
	return 
		
		
