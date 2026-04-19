extends Node

@onready var paths: TileMapLayer = $"../Paths"
@onready var signal_packets: Node = $"../SignalPackets"
@onready var robot: Node2D = $"../Robot"
@onready var landing_zone: Area2D = $"../LandingZone"
signal mission_accomplished
@onready var animation_wait_timer: Timer = $AnimationWaitTimer


var collection_status = Vector3(0,0,0)
var objectives_complete = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cleanup_signal_packets()
	
func cleanup_signal_packets():
	for signal_packet in signal_packets.get_children():
		if signal_packet.position.dot(signal_packet.position)>500**2: signal_packet.queue_free()

func _on_robot_item_collected(name) -> void:	
	if name=='FruitTree': collection_status[0]=1
	elif name=='TwistVine': collection_status[1]=1
	elif name=='BigMushroom': collection_status[2]=1

	if collection_status==Vector3(1,1,1):
		objectives_complete = true
		print("objectives complete")
		animation_wait_timer.start()
		
func do_level_over():
	get_tree().change_scene_to_file("res://game_menu.tscn")

func _on_robot_landing_zone_entered() -> void:
	print("Landing zone entered")
	if objectives_complete:
		"level over"
		do_level_over()

func _on_animation_wait_timer_timeout() -> void:
	mission_accomplished.emit(robot.position)
