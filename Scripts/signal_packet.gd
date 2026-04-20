extends Area2D

@export
var instruction: String = ""
@export
var direction: Vector2
const SPEED = 400.
const MIRROR_ANGLE=PI/4.

@export var sprites: Dictionary[String, CompressedTexture2D] = {"": null, "down": null, "up": null, "left": null, "right": null}

@onready var _my_sprite_renderer: Sprite2D = get_node("./Sprite2D")
@onready var sound_player: SoundPlayer = $SoundPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_my_sprite_renderer.texture = sprites[instruction]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += SPEED*direction*delta
	return

func _on_body_entered(body: Node2D) -> void:
	print('body entered')
	if body.is_in_group("Signal Absorbers"):
		sound_player.play_sound(SoundPlayer.Sounds.PACKET_BLOCKED, false, 0.0, true)
		queue_free()
	if body.is_in_group("Mirrors"):
		reflect(body)
		
func reflect(mirror):
	var d = Vector2(cos(mirror.rotation+MIRROR_ANGLE), sin(mirror.rotation+MIRROR_ANGLE))
	if direction.dot(d)<0:
		direction = direction-2*direction.dot(d)*d
		sound_player.play_sound(SoundPlayer.Sounds.PACKET_REFLECTED)
