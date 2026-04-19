extends Node2D

var mission_accomplished = false
var radius = 0
var center = Vector2(-100,-100)
const SIGNALSPEED = 150.
var dish_position
var max_radius
signal phoneHome

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dish_position = $"../Transmitter".position
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mission_accomplished:
		radius += SIGNALSPEED*delta
		queue_redraw()
		if radius>max_radius:
			phoneHome.emit()
	
func _draw() -> void:
	draw_circle(center, radius, Color("449489"), false, 2.0)

func _on_game_manager_mission_accomplished(position) -> void:
	mission_accomplished = true
	center = position
	max_radius = center.distance_to(dish_position)
	queue_redraw()


func _on_animated_sprite_2d_animation_finished() -> void:
	pass # Replace with function body.
