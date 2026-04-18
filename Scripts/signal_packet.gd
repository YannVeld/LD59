extends Area2D

@export
var instruction: String = ""
@export
var direction: Vector2
const SPEED = 400.

@export var sprites: Dictionary[String, CompressedTexture2D] = {"": null, "down": null, "up": null, "left": null, "right": null}

@onready var _my_sprite_renderer: Sprite2D = get_node("./Sprite2D")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_my_sprite_renderer.texture = sprites[instruction]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += SPEED*direction*delta
	return

func _on_body_entered(body: Node2D) -> void:
	queue_free()
