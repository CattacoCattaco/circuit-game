class_name Level
extends Resource

enum Wall {
	TOP,
	LEFT,
	BOTTOM,
	RIGHT
}

enum WallColor {
	RED,
	BLUE,
	GREY,
}

@export var wall_colors: Array[WallColor] = [
	WallColor.RED,
	WallColor.BLUE,
	WallColor.RED,
	WallColor.BLUE,
]

@export var red_inverted: bool = false
@export var blue_inverted: bool = false

@export var grid_size: int = 7

@export var fixed_tiles: Dictionary[Vector2i, Vector2i] = {}
@export var given_tiles: Array[Vector2i] = []


func _init(p_wall_colors: Array[WallColor] = [WallColor.RED, WallColor.BLUE, WallColor.RED,
		WallColor.BLUE], p_red_inverted: bool = false, p_blue_inverted: bool = false,
		p_grid_size: int = 7, p_fixed_tiles: Dictionary[Vector2i, Vector2i] = {},
		p_given_tiles: Array[Vector2i] = []) -> void:
	wall_colors = p_wall_colors
	
	red_inverted = p_red_inverted
	blue_inverted = p_blue_inverted
	
	grid_size = p_grid_size
	
	fixed_tiles = p_fixed_tiles
	given_tiles = p_given_tiles
