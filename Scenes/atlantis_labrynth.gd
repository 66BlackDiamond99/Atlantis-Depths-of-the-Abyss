extends Node3D

@onready var grid_map = $GridMap
@onready var minimap_grid = $"CanvasLayer/SubViewportContainer/SubViewport/Minimap Grid"
var tiles : Array[MeshInstance3D]
var last_active_tile = null
@onready var player = $Player

@export var grass :PackedScene
@export var MinimapCell :PackedScene
var ofsset = Vector2i(-1,1)

@export var EasyEnemy :PackedScene
@export var MedEnemy :PackedScene
@export var HardEnemy :Array[PackedScene]

var number_of_easy_enemies = 4
var number_of_med_enemies = 2
var number_of_hard_enemies = 1

func _ready():
	var ground_cells: Array[Vector3i]
	for cell in grid_map.get_used_cells():
		if cell.y == -1 and grid_map.get_cell_item(cell) == 0:
			ground_cells.append(cell)
	create_minimap(ground_cells)
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

func create_minimap(ground_cells):
	for cell in ground_cells:
		var cell_in_top_layer = Vector3i(cell.x,0,cell.z)
		var pos = grid_map.to_global(grid_map.map_to_local(cell))
		var tile = MinimapCell.instantiate()
		minimap_grid.add_child(tile)
		tile.global_position = pos
		if grid_map.get_cell_item(cell_in_top_layer) != -1:
			tile.walkable = false
		tiles.append(tile)

func check_movement(player_pos):
	enemy_zone(player_pos)
	var cell = grid_map.local_to_map(grid_map.to_local(player_pos))
	var pos = grid_map.to_global(grid_map.map_to_local(cell))
	for tile in tiles:
		if pos.x == tile.global_position.x and pos.z == tile.global_position.z:
			tile.active = true
			if last_active_tile != null:
				last_active_tile.active = false
			last_active_tile = tile
			break

func enemy_zone(pos):
	var cell = grid_map.local_to_map(grid_map.to_local(pos))
	cell.y = 9
	var cell_type = grid_map.get_cell_item(cell)
	if cell_type == 5:
		if number_of_easy_enemies > 0:
			var chance = randf()
			if chance >= 0.75:
				var enemy = EasyEnemy.instantiate()
				add_child(enemy)
				enemy.look_at(player.global_position,Vector3.UP)
				#Engine.time_scale = 0.3
				enemy.global_position = player.global_position
				enemy.global_position.z -= 0.5
				number_of_easy_enemies -= 1
	if cell_type == 6:
		if number_of_med_enemies > 0:
			var chance = randf()
			if chance >= 0.5:
				var enemy = MedEnemy.instantiate()
				add_child(enemy)
				enemy.global_position = player.global_position
				enemy.look_at(player.global_position,Vector3.UP)
				#enemy.global_position.z -= 0.5
				number_of_med_enemies -= 1
	if cell_type == 7:
		if number_of_hard_enemies > 0:
			var chance = randf()
			if chance >= 0.35:
				var enemy = HardEnemy.pick_random().instantiate()
				add_child(enemy)
				enemy.global_position = player.global_position
				enemy.look_at(player.global_position,Vector3.UP)
				#enemy.global_position.z -= 0.5
				number_of_hard_enemies -= 1
