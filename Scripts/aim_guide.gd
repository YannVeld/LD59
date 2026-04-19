extends Line2D

const LENGTH=1000
var end_point
@onready
var dish = $"../DishSprite"
var start_point 
var heading

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	return	

func draw_next_segment(start_point, heading) -> void:
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(start_point, start_point+heading*LENGTH, (1 << 3 - 1) )
	var result = space_state.intersect_ray(query)
	if not result.has("position"):
		add_point(start_point+heading*LENGTH)
		return
	else:
		add_point(result["position"])
		var body = result["collider"]
		if body.is_in_group("Mirrors"):
			var d = Vector2(cos(body.rotation), sin(body.rotation))
			if heading.dot(d)<0:
				heading = heading-2*heading.dot(d)*d
				draw_next_segment(result["position"], heading)
		return
		
		#

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	clear_points()
	start_point = dish.global_position
	add_point(start_point)
	heading = (get_viewport().get_mouse_position()-start_point).normalized()
	draw_next_segment(start_point, heading)
	pass
