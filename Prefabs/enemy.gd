extends Node3D

@export var type: int
@onready var graphics : Sprite3D = $Graphics 


func _ready():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self,"rotation:x",0,0.3)
	tween.play()
	await tween.finished
	graphics.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
