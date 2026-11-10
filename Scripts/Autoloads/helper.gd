extends Node

const TILE_SIZE := 32

var base_grid_offset := Vector2(16, 16)
var added_grid_offset: Vector2

# Untested currently
# Takes floating point coordinates and maps them to the grid
func real_to_grid(coords: Vector2) -> Vector2i:
	var grid_coords: Vector2i = (coords + base_grid_offset) / TILE_SIZE
	return grid_coords

# Takes grid coordinates and returns floating point coordinates equal to the middle of that grid square
func grid_to_real(coords: Vector2i) -> Vector2:
	var real_coords: Vector2 = Vector2(coords * TILE_SIZE) + base_grid_offset
	return real_coords
