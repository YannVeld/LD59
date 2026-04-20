extends Node2D

@onready var level_buttons = $"Level buttons"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(SessionManager.level_status)
	mark_completed_levels()
	if SessionManager.get_suggested_level() != 0:
		mark_button_as_suggested(level_buttons.get_child(SessionManager.get_suggested_level()-1))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	SessionManager.current_level = 1
	get_tree().change_scene_to_file("res://level1.tscn")

func _on_button_2_pressed() -> void:
	SessionManager.current_level = 2
	get_tree().change_scene_to_file("res://level2.tscn")

func _on_button_3_pressed() -> void:
	SessionManager.current_level = 3
	get_tree().change_scene_to_file("res://level3.tscn")

func _on_button_4_pressed() -> void:
	SessionManager.current_level = 4
	get_tree().change_scene_to_file("res://level4.tscn")

func _on_button_5_pressed() -> void:
	SessionManager.current_level = 5
	get_tree().change_scene_to_file("res://level5.tscn")

func _on_button_6_pressed() -> void:
	SessionManager.current_level = 6
	get_tree().change_scene_to_file("res://level6.tscn")
	
func mark_completed_levels():
	for i in range(1, SessionManager.num_levels+1):
		if SessionManager.level_status[i]:
			mark_button_as_complete(level_buttons.get_child(i-1))

func mark_button_as_complete(button):
	print("need to mark ", button, " as complete")
	button.set("theme_override_colors/font_color", Color.GREEN)
	pass
	
func mark_button_as_suggested(button):
	button.set("theme_override_colors/font_color", Color.RED)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
