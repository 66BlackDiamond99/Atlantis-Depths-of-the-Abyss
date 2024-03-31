extends Camera3D

@onready var player = $"../../../../Player"

func _process(delta):
	global_position = Vector3(\
		player.global_position.x,
		global_position.y,
		player.global_position.z)
