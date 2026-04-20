extends Node2D

@onready var level_buttons = $"Level buttons"
@onready var fader = $"Fader"

signal on_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(SessionManager.level_status)
	mark_completed_levels()
	if SessionManager.get_suggested_level() != 0:
		mark_button_as_suggested(level_buttons.get_child(SessionManager.get_suggested_level()-1))
	#print($"Level buttons/Button3".get_node().has_child(rect))

	if SessionManager.pass_through:
		SessionManager.pass_through = false
		var filename  = "res://level"+str(SessionManager.current_level)+".tscn"
		get_tree().change_scene_to_file(filename)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	on_button_pressed.emit()
	await fader.on_fade_out_finished
	
	SessionManager.current_level = 1
	get_tree().change_scene_to_file("res://level1.tscn")

func _on_button_2_pressed() -> void:
	on_button_pressed.emit()
	await fader.on_fade_out_finished
	
	SessionManager.current_level = 2
	get_tree().change_scene_to_file("res://level2.tscn")

func _on_button_3_pressed() -> void:
	on_button_pressed.emit()
	await fader.on_fade_out_finished
	
	SessionManager.current_level = 3
	get_tree().change_scene_to_file("res://level3.tscn")

func _on_button_4_pressed() -> void:
	on_button_pressed.emit()
	await fader.on_fade_out_finished
	
	SessionManager.current_level = 4
	get_tree().change_scene_to_file("res://level4.tscn")

func _on_button_5_pressed() -> void:
	on_button_pressed.emit()
	await fader.on_fade_out_finished
	
	SessionManager.current_level = 5
	get_tree().change_scene_to_file("res://level5.tscn")

func _on_button_6_pressed() -> void:
	on_button_pressed.emit()
	await fader.on_fade_out_finished
	
	SessionManager.current_level = 6
	get_tree().change_scene_to_file("res://level6.tscn")
	
func mark_completed_levels():
	for i in range(1, SessionManager.num_levels+1):
		if SessionManager.level_status[i]:
			mark_button_as_complete(level_buttons.get_child(i-1))

func mark_button_as_complete(button):
	var rect = ColorRect.new()
	rect.set_size(Vector2(13,13))
	rect.set_position(Vector2(1,1))
	rect.color = Color(0.2,0.6,0.1,0.5)
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	button.add_child(rect)
	pass
	
func mark_button_as_suggested(button):
	button.material.set_shader_parameter('do_blinking', true)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
