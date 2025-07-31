class_name Level
extends Resource

enum WALL {
	TOP,
	LEFT,
	BOTTOM,
	RIGHT
}

enum WALL_COLOR {
	RED,
	BLUE,
	GREY,
}

@export var wall_colors: Array[WALL_COLOR] = [
	WALL_COLOR.RED,
	WALL_COLOR.BLUE,
	WALL_COLOR.RED,
	WALL_COLOR.BLUE,
]

@export var red_inverted: bool = false
@export var blue_inverted: bool = false

@export var grid_size: int = 7

@export var fixed_tiles: Dictionary[Vector2i, Vector2i] = {}


func _init(p_wall_colors: Array[WALL_COLOR] = [WALL_COLOR.RED, WALL_COLOR.BLUE, WALL_COLOR.RED,
		WALL_COLOR.BLUE], p_red_inverted: bool = false, p_blue_inverted: bool = false,
		p_grid_size: int = 7, p_fixed_tiles: Dictionary[Vector2i, Vector2i] = {}) -> void:
	wall_colors = p_wall_colors
	
	red_inverted = p_red_inverted
	blue_inverted = p_blue_inverted
	
	grid_size = p_grid_size
	
	fixed_tiles = p_fixed_tiles
