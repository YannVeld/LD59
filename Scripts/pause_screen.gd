extends CanvasGroup


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			self.show()
		else:
			self.hide()


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game_menu.tscn")
	pass # Replace with function body.
