extends Node

@onready var paths: TileMapLayer = $"../Paths"
@onready var signal_packets: Node = $"../SignalPackets"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cleanup_signal_packets()
	pass
	
func cleanup_signal_packets():
	for signal_packet in signal_packets.get_children():
		if signal_packet.position.dot(signal_packet.position)>500**2: signal_packet.queue_free()

			
