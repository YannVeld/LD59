extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level1.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://level2.tscn")

func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://level3.tscn")

func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://level4.tscn")

func _on_button_5_pressed() -> void:
	get_tree().change_scene_to_file("res://level5.tscn")

func _on_button_6_pressed() -> void:
	get_tree().change_scene_to_file("res://level6.tscn")
