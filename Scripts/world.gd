extends Node2D

const TILE_SIZE := 32

@export_category("Level Gen")
@export var level_width: int = 5
@export var level_height: int = 5

@export var x_offset: int = 1
@export var y_offset: int = 1

@onready var wall_tiles = %WallTiles
@onready var floor_tiles = %FloorTiles

var treasure_count := 0

func _ready() -> void:
	generate_level()

# Runs everything needed to get the level generated
func generate_level():
	wall_tiles.clear()
	floor_tiles.clear()
	
	generate_walls()
	generate_floor()
	populate_level()

# Poorly implemented (but functional!) way of making a border rect pretty much by hand since I didn't want to fix the autotiling issues
func generate_walls():
	#Corners
	wall_tiles.set_cell(Vector2i(0, 0), 0, Vector2i(0, 0))
	wall_tiles.set_cell(Vector2i(level_width + 1, 0), 0, Vector2i(2, 0))
	wall_tiles.set_cell(Vector2i(0, level_height + 1), 0, Vector2i(0, 2))
	wall_tiles.set_cell(Vector2i(level_width + 1, level_height + 1), 0, Vector2i(2, 2))
	#Edges
	for i in range(1, level_width + 1):
		wall_tiles.set_cell(Vector2i(i, 0), 0, Vector2i(1, 0))
		wall_tiles.set_cell(Vector2i(i, level_height + 1), 0, Vector2i(1, 2))
	for j in range(1, level_height + 1):
		wall_tiles.set_cell(Vector2i(0, j), 0, Vector2i(0, 1))
		wall_tiles.set_cell(Vector2i(level_width + 1, j), 0, Vector2i(2, 1))

# Floor square with weighted random tiles (see random_floor_tile())
func generate_floor():
	for i in range(level_width):
		for j in range(level_height):
			floor_tiles.set_cell(Vector2i(i + x_offset, j + y_offset), 5, random_floor_tile())

# Returns a randomized atlas coordinate, weighted with a bias towards the default texture
func random_floor_tile() -> Vector2i:
	var rand = randf()
	var atlas_coords: Vector2i

	if rand < 0.7: #chance for the basic tile
		atlas_coords = Vector2i(0, 0)
	else:
		atlas_coords = [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)].pick_random()
	return atlas_coords

# Adds the fun stuff to the level
func populate_level():
	$Player.position = Helper.grid_to_real(Vector2i(1, level_height))
	$Chest.position = Helper.grid_to_real(Vector2i(2, 2))
	$Chest.collected.connect(get_treasure)

#probably a temporary function - for testing
func get_treasure(amount: int):
	treasure_count += amount
	$UI/HBoxContainer/VBoxContainer/TreasureCounter.text = str(treasure_count)
