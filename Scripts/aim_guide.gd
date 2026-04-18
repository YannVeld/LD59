extends Line2D

const LENGTH=1000
var end_point
@onready
var dish = $"../DishSprite"
var start_point

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_point = dish.global_position
	add_point(start_point)
	end_point = start_point+(get_viewport().get_mouse_position()-start_point).normalized()*LENGTH
	add_point(end_point)
	return	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	end_point = start_point+(get_viewport().get_mouse_position()-start_point).normalized()*LENGTH
	set_point_position(1, end_point)
	pass
