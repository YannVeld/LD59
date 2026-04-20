extends Node2D

@export
var level_status: Dictionary
@export
var num_levels = 6
@export
var current_level = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(1, num_levels+1):
		level_status[i] = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func get_suggested_level() -> int:
	for level in level_status:
		if not level_status[level]:
			return level
	return 0
			
