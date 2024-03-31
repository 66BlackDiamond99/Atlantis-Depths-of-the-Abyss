extends MeshInstance3D

@export var ActiveColor: Color
@export var InActiveColor: Color
@export var NotWalkableColor: Color
@export var EnemyHereColor:Color

@export var enemy_here = false:
	get:
		return enemy_here
	set(value):
		enemy_here = value
		if enemy_here:
			material_override = StandardMaterial3D.new()
			material_override.albedo_color = EnemyHereColor
			material_override.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		else:
			material_override = StandardMaterial3D.new()
			material_override.albedo_color = InActiveColor
			material_override.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
@export var walkable = true:
	get:
		return walkable
	set(value):
		walkable = value
		if not walkable:
			material_override = StandardMaterial3D.new()
			material_override.albedo_color = NotWalkableColor
			material_override.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
@export var active = false:
	get:
		return active
	set(value):
		active = value
		if active:
			material_override = StandardMaterial3D.new()
			material_override.albedo_color = ActiveColor
			material_override.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		else:
			material_override = StandardMaterial3D.new()
			material_override.albedo_color = InActiveColor
			material_override.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
