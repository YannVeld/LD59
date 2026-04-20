extends Node

@onready var paths: TileMapLayer = $"../Paths"
@onready var signal_packets: Node = $"../SignalPackets"
@onready var robot: Node2D = $"../Robot"
@onready var landing_zone: Area2D = $"../LandingZone"
signal mission_accomplished
@onready var animation_wait_timer: Timer = $AnimationWaitTimer
@onready var sound_player: SoundPlayer = $SoundPlayer
@onready var robot_takeoff: RobotTakeoff = $"../RobotTakeoff"

var collection_status = Vector3(0,0,0)
var objectives_complete = false
var robot_has_taken_off = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Entering level ", SessionManager.current_level)
	$"../Control".modulate.a = 0
	$"../Control/LevelLabel".text += str(SessionManager.current_level)

	
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
		sound_player.play_sound(SoundPlayer.Sounds.ROBO_PHONE_HOME, false, 1.0)
		
func do_level_over():
	robot.set_process(false)
	robot.visible = false
	robot_takeoff.start_takeoff()
	robot_has_taken_off = true
	sound_player.play_sound(SoundPlayer.Sounds.SUCCES_JINGLE)

func _on_robot_landing_zone_entered() -> void:
	print("Landing zone entered")
	if objectives_complete:
		"level over"
		do_level_over()

func _on_animation_wait_timer_timeout() -> void:
	mission_accomplished.emit(robot.position)

func _on_fader_on_fade_out_finished() -> void:
	if robot_has_taken_off:
		SessionManager.level_status[SessionManager.current_level] = true
		var next_level = SessionManager.get_suggested_level()
		if next_level != 0:
			SessionManager.current_level = next_level
			var filename  = "res://level"+str(next_level)+".tscn"
			#get_tree().change_scene_to_file(filename) # Just doing seems to cause issues with the shaders.
			SessionManager.pass_through = true		
		get_tree().change_scene_to_file("res://game_menu.tscn")
		
	else:
		get_tree().change_scene_to_file("res://game_menu.tscn")
		
func modulate_in(thing, duration):
	thing.modulate.a = 0
	
	var tween = create_tween()
	tween.tween_property(thing, "modulate:a", 1., duration)
	
func modulate_out(thing, duration):
	thing.modulate.a = 1
	
	var tween = create_tween()
	tween.tween_property(thing, "modulate:a", 0., duration)

func _on_fader_on_fade_in_finished() -> void:
	modulate_in($"../Control", 3)
	$"../Control/LevelLabelTimer".start(2.5)
	pass # Replace with function body.

func _on_level_label_timer_timeout() -> void:
	modulate_out($"../Control", 1)
	pass # Replace with function body.
