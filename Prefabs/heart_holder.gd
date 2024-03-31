extends Node3D

var show_core = false;
var core_pieces = 8
var collected_pieces = 0;

@onready var heart = $Heart
@onready var omni_light_3d = $OmniLight3D

func _ready():
	if show_core:
		heart.show()
		omni_light_3d.show()
	else:
		heart.hide()
		omni_light_3d.hide()

func add_piece():
	collected_pieces += 1
	core_pieces -= 1
	if core_pieces <= 0:
		heart.show()
