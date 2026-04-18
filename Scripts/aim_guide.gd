extends Line2D

const LENGTH=1000
var end_point
@onready
var dish = $"../DishSprite"
var start_point
var heading

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_point = dish.global_position
	#start_point = Vector2(0,0)
	add_point(start_point)
	heading = (get_viewport().get_mouse_position()-start_point).normalized()
	draw_next_segment(start_point, heading, 0)
	end_point = start_point+heading*LENGTH
	add_point(end_point)
	return	
	

func draw_next_segment(start_point, heading, idx) -> bool:
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(start_point, start_point+heading*LENGTH, (1 << 3 - 1) )
	var result = space_state.intersect_ray(query)
	print(result)
	if not result.has("position"):
		print("true")
		set_point_position(idx+1, start_point+heading*LENGTH)
		return true
	else:
		print(false)
		set_point_position(idx+1, result["position"])
		return false
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	heading = (get_viewport().get_mouse_position()-start_point).normalized()
	draw_next_segment(start_point, heading, 0)
	pass
