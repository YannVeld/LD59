extends Node2D

var collected = false

@export
var type : String

@export
var area_2D : Area2D

@export
var sprite_2D: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2D.body_entered.connect(on_pickup)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func on_pickup():
	print(type, " has been collected")
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
