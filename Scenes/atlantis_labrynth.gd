extends Node3D

@onready var grid_map = $GridMap

@export var grass :PackedScene
var ofsset = Vector2i(-1,1)

func _ready():
	var ground_cells: Array[Vector3i]
	for cell in grid_map.get_used_cells():
		if cell.y == -1 and grid_map.get_cell_item(cell) == 0:
			ground_cells.append(cell)
	var positions: Array[Vector3]
	for i in range(ground_cells.size()*0.85):
		var random_cell = ground_cells.pick_random()
		var pos = Vector3(random_cell.x,grid_map.to_global(grid_map.map_to_local(random_cell)).y,random_cell.z)
		positions.append(pos)
	var grass_holder = Node3D.new()
	grass_holder.name = "Mini Grass Patch"
	add_child(grass_holder)
	for pos in positions:
		var mini_grass = grass.instantiate() as Node3D
		grass_holder.add_child(mini_grass)
		mini_grass.global_position = Vector3(pos.x+randf_range(ofsset.x,ofsset.y),pos.y+0.35,pos.z+randf_range(ofsset.x,ofsset.y))
