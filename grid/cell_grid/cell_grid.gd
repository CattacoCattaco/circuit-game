class_name CellGrid
extends GridContainer

@export var cell_scene: PackedScene

@export var level: Level

var cells: Array[Cell] = []


func _ready() -> void:
	load_grid()


func load_grid() -> void:
	for cell in cells:
		cell.queue_free()
	
	cells = []
	
	columns = level.grid_size
	
	var end: int = level.grid_size - 1
	var middle: int = end >> 1
	
	var red_walls: Array[int] = []
	var blue_walls: Array[int] = []
	var grey_walls: Array[int] = []
	
	for wall in len(level.wall_colors):
		if level.wall_colors[wall] == level.WALL_COLOR.RED:
			red_walls.append(wall)
		elif level.wall_colors[wall] == level.WALL_COLOR.BLUE:
			blue_walls.append(wall)
		elif level.wall_colors[wall] == level.WALL_COLOR.GREY:
			grey_walls.append(wall)
	
	var inverted_walls: Array[int] = []
	
	if red_walls and level.red_inverted:
		inverted_walls.append(red_walls[1])
	if blue_walls and level.blue_inverted:
		inverted_walls.append(blue_walls[1])
	
	for y in range(level.grid_size):
		for x in range(level.grid_size):
			var cell: Cell = cell_scene.instantiate()
			
			cell.pos = Vector2i(x, y)
			cell.cell_grid = self
			cell.powered = false
			
			add_child(cell)
			cells.append(cell)
			
			match [x, y]:
				[0, 0]:
					var corner_row: int = get_corner_tile_row(
							level.wall_colors[level.WALL.TOP], 
							level.wall_colors[level.WALL.LEFT]
					)
					cell.set_tile(Vector2i(0, corner_row))
				[end, 0]:
					var corner_row: int = get_corner_tile_row(
							level.wall_colors[level.WALL.TOP], 
							level.wall_colors[level.WALL.RIGHT]
					)
					cell.set_tile(Vector2i(1, corner_row))
				[end, end]:
					var corner_row: int = get_corner_tile_row(
							level.wall_colors[level.WALL.BOTTOM], 
							level.wall_colors[level.WALL.RIGHT]
					)
					cell.set_tile(Vector2i(2, corner_row))
				[0, end]:
					var corner_row: int = get_corner_tile_row(
							level.wall_colors[level.WALL.BOTTOM], 
							level.wall_colors[level.WALL.LEFT]
					)
					cell.set_tile(Vector2i(3, corner_row))
				[middle, 0]:
					cell.set_tile(get_arrow_tile_pos(level.WALL.TOP, inverted_walls))
				[middle, end]:
					cell.set_tile(get_arrow_tile_pos(level.WALL.BOTTOM, inverted_walls))
				[0, middle]:
					cell.set_tile(get_arrow_tile_pos(level.WALL.LEFT, inverted_walls))
				[end, middle]:
					cell.set_tile(get_arrow_tile_pos(level.WALL.RIGHT, inverted_walls))
				[_, 0]:
					cell.set_tile(get_side_tile_pos(level.WALL.TOP))
				[_, end]:
					cell.set_tile(get_side_tile_pos(level.WALL.BOTTOM))
				[0, _]:
					cell.set_tile(get_side_tile_pos(level.WALL.LEFT))
				[end, _]:
					cell.set_tile(get_side_tile_pos(level.WALL.RIGHT))
				[_, _]:
					if Vector2i(x, y) in level.fixed_tiles:
						cell.set_tile(level.fixed_tiles[Vector2i(x, y)])
						cell.set_frame(Vector2i(0, 0))


func get_corner_tile_row(horizontal_color: int, vertical_color: int) -> int:
	match [horizontal_color, vertical_color]:
		[level.WALL_COLOR.BLUE, level.WALL_COLOR.BLUE]:
			return 15
		[level.WALL_COLOR.BLUE, level.WALL_COLOR.RED]:
			return 16
		[level.WALL_COLOR.RED, level.WALL_COLOR.BLUE]:
			return 17
		[level.WALL_COLOR.RED, level.WALL_COLOR.RED]:
			return 18
		[level.WALL_COLOR.GREY, level.WALL_COLOR.GREY]:
			return 19
		[level.WALL_COLOR.GREY, level.WALL_COLOR.RED]:
			return 20
		[level.WALL_COLOR.RED, level.WALL_COLOR.GREY]:
			return 21
	
	return 0


func get_arrow_tile_pos(direction: int, inverted_walls: Array[int]) -> Vector2i:
	var side_pos: Vector2i = get_side_tile_pos(direction)
	
	if level.wall_colors[direction] == level.WALL_COLOR.GREY:
		return side_pos
	
	if direction in inverted_walls:
		return side_pos - Vector2i(0, 1)
	
	return side_pos - Vector2i(0, 2)


func get_side_tile_pos(direction: int) -> Vector2i:
	match level.wall_colors[direction]:
		Level.WALL_COLOR.BLUE:
			return Vector2i(direction, 10)
		Level.WALL_COLOR.RED:
			return Vector2i(direction, 13)
		Level.WALL_COLOR.GREY:
			return Vector2i(direction, 14)
	
	return Vector2i(direction, 0)


func get_cell(x: int, y: int) -> Cell:
	return cells[x + y * level.grid_size]


func get_cell_by_vec(vec: Vector2i) -> Cell:
	return cells[vec.x + vec.y * level.grid_size]
