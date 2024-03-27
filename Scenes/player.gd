extends Node3D

const TRAVEL_TIME := 0.3

@onready var forward_ray = $"Forward Ray"
@onready var backward_ray = $"Backward Ray"
@onready var left_ray = $"Left Ray"
@onready var right_ray = $"Right Ray"
var Dir = Vector3.FORWARD
var tween = null

func _physics_process(delta):
	if tween != null:
		if tween.is_running():
			return
	if Input.is_action_pressed("forward") and not forward_ray.is_colliding():
		tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_transform", global_transform.translated(-global_transform.basis.z.normalized()), TRAVEL_TIME)
		#animation.play("headbob")
	if Input.is_action_pressed("backward") and not backward_ray.is_colliding():
		tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_transform", global_transform.translated(global_transform.basis.z.normalized()), TRAVEL_TIME)
		#animation.play("headbob")
	if Input.is_action_pressed("left") and not left_ray.is_colliding():
		tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_transform", global_transform.translated(-global_transform.basis.x.normalized()), TRAVEL_TIME)
		#animation.play("headbob")
	if Input.is_action_pressed("right") and not right_ray.is_colliding():
		tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_transform", global_transform.translated(global_transform.basis.x.normalized()), TRAVEL_TIME)
		#animation.play("headbob")
	if Input.is_action_pressed("rotate-left"):
		tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "global_transform:basis", global_transform.basis.rotated(global_transform.basis.y, PI / 2), TRAVEL_TIME)
	if Input.is_action_pressed("rotate-right"):
		tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y",rotation.y - PI / 2, TRAVEL_TIME)
