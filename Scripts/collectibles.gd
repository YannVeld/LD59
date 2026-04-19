extends Area2D

@onready var robot: Area2D = $"../Robot"
@export var prevent_zorder_changes = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not prevent_zorder_changes:
		if robot.position.y < position.y:
			$Sprite2D.z_index = 2
		else:
			$Sprite2D.z_index = 0
		pass
	
func turn_off_shader():
	$Sprite2D.material.set_shader_parameter('do_blinking', false)
