class_name CellGrid
extends GridContainer

@export var cell_scene: PackedScene

@export var current_level_index: int

var levels: Array[Level] = []

var cells: Array[Cell] = []

var placeable_cells: Array[Cell] = []
var placeable_tiles: Array[Vector2i] = []
var placeable_tile_page: int = 0

var left_placeable_arrow: Cell
var right_placeable_arrow: Cell

var selected_placeable_cell: Cell

var placed_cells: Dictionary[Vector2i, Cell] = {}
var side_cells: Dictionary[Vector2i, Cell] = {}

var lit_LEDS: Array[Cell] = []

var total_LED_count: int = 0

var submit_check: Cell


func load_grid() -> void:
	for cell in cells:
		cell.queue_free()
	
	cells = []
	placeable_cells = []
	placeable_tiles = []
	placeable_tile_page = 0
	selected_placeable_cell = null
	placed_cells = {}
	side_cells = {}
	lit_LEDS = []
	total_LED_count = 0
	
	columns = levels[current_level_index].grid_size + 2
	
	var placeable_row: int = levels[current_level_index].grid_size
	
	var end: int = levels[current_level_index].grid_size - 1
	var middle: int = end >> 1
	
	var red_walls: Array[int] = []
	var blue_walls: Array[int] = []
	var grey_walls: Array[int] = []
	
	for wall in len(levels[current_level_index].wall_colors):
		if levels[current_level_index].wall_colors[wall] == Level.WallColor.RED:
			red_walls.append(wall)
		elif levels[current_level_index].wall_colors[wall] == Level.WallColor.BLUE:
			blue_walls.append(wall)
		elif levels[current_level_index].wall_colors[wall] == Level.WallColor.GREY:
			grey_walls.append(wall)
	
	var inverted_walls: Array[int] = []
	
	if red_walls and levels[current_level_index].red_inverted:
		inverted_walls.append(red_walls[1])
	if blue_walls and levels[current_level_index].blue_inverted:
		inverted_walls.append(blue_walls[1])
	
	for y in range(levels[current_level_index].grid_size + 2):
		for x in range(levels[current_level_index].grid_size + 2):
			var adjusted_x: int = x - 1
			var adjusted_y: int = y - 1
			
			var cell: Cell = cell_scene.instantiate()
			
			cell.board_pos = Vector2i(adjusted_x, adjusted_y)
			cell.cell_grid = self
			cell.powered = false
			
			add_child(cell)
			cells.append(cell)
			
			match [adjusted_x, adjusted_y]:
				[-1, placeable_row]:
					cell.set_tile(Tiles.BLANK)
					cell.area = Cell.Area.PLACEABLE_ARROWS
					
					left_placeable_arrow = cell
				[placeable_row, placeable_row]:
					cell.set_tile(Tiles.RIGHT_ARROW)
					cell.area = Cell.Area.PLACEABLE_ARROWS
					
					right_placeable_arrow = cell
				[placeable_row, middle]:
					cell.set_tile(Tiles.SUBMIT_CHECK)
					cell.area = Cell.Area.SUBMIT_CHECK
					submit_check = cell
				[-1, _]:
					cell.set_tile(Tiles.BLANK)
					cell.area = Cell.Area.EMPTY
				[placeable_row, _]:
					cell.set_tile(Tiles.BLANK)
					cell.area = Cell.Area.EMPTY
				[_, -1]:
					cell.set_tile(Tiles.BLANK)
					cell.area = Cell.Area.EMPTY
				[_, placeable_row]:
					placeable_cells.append(cell)
					cell.area = Cell.Area.PLACEABLES
				[0, 0]:
					var corner_row: int = get_corner_tile_row(
							levels[current_level_index].wall_colors[Level.Wall.TOP], 
							levels[current_level_index].wall_colors[Level.Wall.LEFT]
					)
					cell.set_tile(Vector2i(0, corner_row))
					cell.area = Cell.Area.BOARD_SIDES
				[end, 0]:
					var corner_row: int = get_corner_tile_row(
							levels[current_level_index].wall_colors[Level.Wall.TOP], 
							levels[current_level_index].wall_colors[Level.Wall.RIGHT]
					)
					cell.set_tile(Vector2i(1, corner_row))
					cell.area = Cell.Area.BOARD_SIDES
				[end, end]:
					var corner_row: int = get_corner_tile_row(
							levels[current_level_index].wall_colors[Level.Wall.BOTTOM], 
							levels[current_level_index].wall_colors[Level.Wall.RIGHT]
					)
					cell.set_tile(Vector2i(2, corner_row))
					cell.area = Cell.Area.BOARD_SIDES
				[0, end]:
					var corner_row: int = get_corner_tile_row(
							levels[current_level_index].wall_colors[Level.Wall.BOTTOM], 
							levels[current_level_index].wall_colors[Level.Wall.LEFT]
					)
					cell.set_tile(Vector2i(3, corner_row))
					cell.area = Cell.Area.BOARD_SIDES
				[middle, 0]:
					cell.set_tile(get_arrow_tile_pos(Level.Wall.TOP, inverted_walls))
					cell.area = Cell.Area.BOARD_SIDES
					side_cells[Vector2i(adjusted_x, adjusted_y)] = cell
					
					var side: int = Level.Wall.TOP
					var relevant_coord: int = adjusted_x
					
					var other_side: int = -1
					if side in red_walls:
						other_side = (red_walls[0] if red_walls[0] != side else red_walls[1])
					elif side in blue_walls:
						other_side = (blue_walls[0] if blue_walls[0] != side
								else blue_walls[1])
					
					if other_side != -1:
						var linked_pos: Vector2i = get_side_tile_connection(
							side,
							other_side,
							relevant_coord,
							inverted_walls,
							end
						)
						if linked_pos in side_cells:
							cell.linked_cell = side_cells[linked_pos]
							side_cells[linked_pos].linked_cell = cell
				[middle, end]:
					cell.set_tile(get_arrow_tile_pos(Level.Wall.BOTTOM, inverted_walls))
					cell.area = Cell.Area.BOARD_SIDES
					side_cells[Vector2i(adjusted_x, adjusted_y)] = cell
					
					var side: int = Level.Wall.BOTTOM
					var relevant_coord: int = adjusted_x
					
					var other_side: int = -1
					if side in red_walls:
						other_side = (red_walls[0] if red_walls[0] != side else red_walls[1])
					elif side in blue_walls:
						other_side = (blue_walls[0] if blue_walls[0] != side
								else blue_walls[1])
					
					if other_side != -1:
						var linked_pos: Vector2i = get_side_tile_connection(
							side,
							other_side,
							relevant_coord,
							inverted_walls,
							end
						)
						if linked_pos in side_cells:
							cell.linked_cell = side_cells[linked_pos]
							side_cells[linked_pos].linked_cell = cell
				[0, middle]:
					cell.set_tile(get_arrow_tile_pos(Level.Wall.LEFT, inverted_walls))
					cell.area = Cell.Area.BOARD_SIDES
					side_cells[Vector2i(adjusted_x, adjusted_y)] = cell
					
					var side: int = Level.Wall.LEFT
					var relevant_coord: int = adjusted_y
					
					var other_side: int = -1
					if side in red_walls:
						other_side = (red_walls[0] if red_walls[0] != side else red_walls[1])
					elif side in blue_walls:
						other_side = (blue_walls[0] if blue_walls[0] != side
								else blue_walls[1])
					
					if other_side != -1:
						var linked_pos: Vector2i = get_side_tile_connection(
							side,
							other_side,
							relevant_coord,
							inverted_walls,
							end
						)
						if linked_pos in side_cells:
							cell.linked_cell = side_cells[linked_pos]
							side_cells[linked_pos].linked_cell = cell
				[end, middle]:
					cell.set_tile(get_arrow_tile_pos(Level.Wall.RIGHT, inverted_walls))
					cell.area = Cell.Area.BOARD_SIDES
					side_cells[Vector2i(adjusted_x, adjusted_y)] = cell
					
					var side: int = Level.Wall.RIGHT
					var relevant_coord: int = adjusted_y
					
					var other_side: int = -1
					if side in red_walls:
						other_side = (red_walls[0] if red_walls[0] != side else red_walls[1])
					elif side in blue_walls:
						other_side = (blue_walls[0] if blue_walls[0] != side
								else blue_walls[1])
					
					if other_side != -1:
						var linked_pos: Vector2i = get_side_tile_connection(
							side,
							other_side,
							relevant_coord,
							inverted_walls,
							end
						)
						if linked_pos in side_cells:
							cell.linked_cell = side_cells[linked_pos]
							side_cells[linked_pos].linked_cell = cell
				[_, 0]:
					cell.set_tile(get_side_tile_pos(Level.Wall.TOP))
					cell.area = Cell.Area.BOARD_SIDES
					side_cells[Vector2i(adjusted_x, adjusted_y)] = cell
					
					var side: int = Level.Wall.TOP
					var relevant_coord: int = adjusted_x
					
					var other_side: int = -1
					if side in red_walls:
						other_side = (red_walls[0] if red_walls[0] != side else red_walls[1])
					elif side in blue_walls:
						other_side = (blue_walls[0] if blue_walls[0] != side
								else blue_walls[1])
					
					if other_side != -1:
						var linked_pos: Vector2i = get_side_tile_connection(
							side,
							other_side,
							relevant_coord,
							inverted_walls,
							end
						)
						if linked_pos in side_cells:
							cell.linked_cell = side_cells[linked_pos]
							side_cells[linked_pos].linked_cell = cell
				[_, end]:
					cell.set_tile(get_side_tile_pos(Level.Wall.BOTTOM))
					cell.area = Cell.Area.BOARD_SIDES
					side_cells[Vector2i(adjusted_x, adjusted_y)] = cell
					
					var side: int = Level.Wall.BOTTOM
					var relevant_coord: int = adjusted_x
					
					var other_side: int = -1
					if side in red_walls:
						other_side = (red_walls[0] if red_walls[0] != side else red_walls[1])
					elif side in blue_walls:
						other_side = (blue_walls[0] if blue_walls[0] != side
								else blue_walls[1])
					
					if other_side != -1:
						var linked_pos: Vector2i = get_side_tile_connection(
							side,
							other_side,
							relevant_coord,
							inverted_walls,
							end
						)
						if linked_pos in side_cells:
							cell.linked_cell = side_cells[linked_pos]
							side_cells[linked_pos].linked_cell = cell
				[0, _]:
					cell.set_tile(get_side_tile_pos(Level.Wall.LEFT))
					cell.area = Cell.Area.BOARD_SIDES
					side_cells[Vector2i(adjusted_x, adjusted_y)] = cell
					
					var side: int = Level.Wall.LEFT
					var relevant_coord: int = adjusted_y
					
					var other_side: int = -1
					if side in red_walls:
						other_side = (red_walls[0] if red_walls[0] != side else red_walls[1])
					elif side in blue_walls:
						other_side = (blue_walls[0] if blue_walls[0] != side
								else blue_walls[1])
					
					if other_side != -1:
						var linked_pos: Vector2i = get_side_tile_connection(
							side,
							other_side,
							relevant_coord,
							inverted_walls,
							end
						)
						if linked_pos in side_cells:
							cell.linked_cell = side_cells[linked_pos]
							side_cells[linked_pos].linked_cell = cell
				[end, _]:
					cell.set_tile(get_side_tile_pos(Level.Wall.RIGHT))
					cell.area = Cell.Area.BOARD_SIDES
					side_cells[Vector2i(adjusted_x, adjusted_y)] = cell
					
					var side: int = Level.Wall.RIGHT
					var relevant_coord: int = adjusted_y
					
					var other_side: int = -1
					if side in red_walls:
						other_side = (red_walls[0] if red_walls[0] != side else red_walls[1])
					elif side in blue_walls:
						other_side = (blue_walls[0] if blue_walls[0] != side
								else blue_walls[1])
					
					if other_side != -1:
						var linked_pos: Vector2i = get_side_tile_connection(
							side,
							other_side,
							relevant_coord,
							inverted_walls,
							end
						)
						if linked_pos in side_cells:
							cell.linked_cell = side_cells[linked_pos]
							side_cells[linked_pos].linked_cell = cell
				[_, _]:
					cell.area = Cell.Area.BOARD_CELLS
					var fixed_tiles: Dictionary[Vector2i, Vector2i]
					fixed_tiles = levels[current_level_index].fixed_tiles
					
					if Vector2i(adjusted_x, adjusted_y) in fixed_tiles:
						cell.set_tile(fixed_tiles[Vector2i(adjusted_x, adjusted_y)])
						cell.set_frame(Frames.FORCED)
						placed_cells[Vector2i(adjusted_x, adjusted_y)] = cell
						
						if fixed_tiles[Vector2i(adjusted_x, adjusted_y)] in Tiles.LED_TILES:
							total_LED_count += 1
	
	for tile in levels[current_level_index].given_tiles:
		if tile in Tiles.LED_TILES:
			total_LED_count += 1
	
	placeable_tiles = levels[current_level_index].given_tiles.duplicate()
	display_placeable_tiles()
	
	check_power()


func get_corner_tile_row(horizontal_color: int, vertical_color: int) -> int:
	match [horizontal_color, vertical_color]:
		[Level.WallColor.BLUE, Level.WallColor.BLUE]:
			return Tiles.BLUE_BLUE_CORNER_ROW
		[Level.WallColor.BLUE, Level.WallColor.RED]:
			return Tiles.BLUE_RED_CORNER_ROW
		[Level.WallColor.RED, Level.WallColor.BLUE]:
			return Tiles.RED_BLUE_CORNER_ROW
		[Level.WallColor.RED, Level.WallColor.RED]:
			return Tiles.RED_RED_CORNER_ROW
		[Level.WallColor.GREY, Level.WallColor.GREY]:
			return Tiles.GREY_GREY_CORNER_ROW
		[Level.WallColor.GREY, Level.WallColor.RED]:
			return Tiles.GREY_RED_CORNER_ROW
		[Level.WallColor.RED, Level.WallColor.GREY]:
			return Tiles.RED_GREY_CORNER_ROW
	
	return 0


func get_side_tile_connection(side: int, paired_side: int, relevant_coord: int, 
		inverted_walls: Array[int], end: int) -> Vector2i:
	var inverted: bool = side in inverted_walls or (side + 2) & 3 in inverted_walls
	
	var new_relevant_coord: int
	
	if inverted:
		new_relevant_coord = levels[current_level_index].grid_size - relevant_coord - 1
	else:
		new_relevant_coord = relevant_coord
	
	match paired_side:
		Level.Wall.TOP:
			return Vector2i(new_relevant_coord, 0)
		Level.Wall.LEFT:
			return Vector2i(0, new_relevant_coord)
		Level.Wall.BOTTOM:
			return Vector2i(new_relevant_coord, end)
		Level.Wall.RIGHT:
			return Vector2i(end, new_relevant_coord)
	
	return Vector2i(0, 0)


func get_arrow_tile_pos(side: int, inverted_walls: Array[int]) -> Vector2i:
	var side_pos: Vector2i = get_side_tile_pos(side)
	
	if levels[current_level_index].wall_colors[side] == Level.WallColor.GREY:
		return side_pos
	
	if side in inverted_walls:
		return side_pos - Vector2i(0, 1)
	
	return side_pos - Vector2i(0, 2)


func get_side_tile_pos(side: int) -> Vector2i:
	match levels[current_level_index].wall_colors[side]:
		Level.WallColor.BLUE:
			return Vector2i(side, Tiles.BLUE_SIDE_ROW)
		Level.WallColor.RED:
			return Vector2i(side, Tiles.RED_SIDE_ROW)
		Level.WallColor.GREY:
			return Vector2i(side, Tiles.GREY_SIDE_ROW)
	
	return Vector2i(side, 0)


func get_cell(x: int, y: int) -> Cell:
	return cells[x + y * levels[current_level_index].grid_size]


func get_cell_by_vec(vec: Vector2i) -> Cell:
	return cells[vec.x + vec.y * levels[current_level_index].grid_size]


func add_tile_to_placeables(tile: Vector2i) -> void:
	var next_placeable_cell: Cell = placeable_cells[len(placeable_tiles)]
	placeable_tiles.append(tile)
	next_placeable_cell.set_tile(tile)


func remove_placeable_cell(cell: Cell) -> void:
	placeable_tiles.erase(cell.tile)
	cell.set_tile(Tiles.EMPTY_CELL)
	cell.deselect()
	if selected_placeable_cell == cell:
		selected_placeable_cell = null
	
	display_placeable_tiles()


func display_placeable_tiles() -> void:
	for i in len(placeable_cells):
		var placeable_tiles_index: int = i + placeable_tile_page * len(placeable_cells)
		if placeable_tiles_index < len(placeable_tiles):
			placeable_cells[i].set_tile(placeable_tiles[placeable_tiles_index])
		else:
			placeable_cells[i].set_tile(Tiles.EMPTY_CELL)


func next_placeable_page() -> void:
	var page_count: int = ceili(len(placeable_tiles) / (len(placeable_cells) as float))
	
	if placeable_tile_page < page_count - 1:
		left_placeable_arrow.set_tile(Tiles.LEFT_ARROW)
		
		placeable_tile_page += 1
		display_placeable_tiles()
		
		if placeable_tile_page == page_count - 1:
			right_placeable_arrow.set_tile(Tiles.BLANK)


func prev_placeable_page() -> void:
	if placeable_tile_page > 0:
		right_placeable_arrow.set_tile(Tiles.RIGHT_ARROW)
		
		placeable_tile_page -= 1
		display_placeable_tiles()
		
		if placeable_tile_page == 0:
			left_placeable_arrow.set_tile(Tiles.BLANK)


func check_power(tiles_removed: bool = false) -> void:
	if tiles_removed:
		for pos in placed_cells:
			var cell: Cell = placed_cells[pos]
			if not cell.is_power_source():
				if cell in lit_LEDS:
					lit_LEDS.erase(cell)
				
				cell.powered = false
				cell.set_tile(cell.tile)
	
	for pos in placed_cells:
		check_power_spread(pos)
	
	for pos in side_cells:
		check_power_spread(pos)
	
	if len(lit_LEDS) == total_LED_count:
		submit_check.powered = true
		submit_check.set_tile(submit_check.tile)
	elif submit_check.powered:
		submit_check.powered = false
		submit_check.set_tile(submit_check.tile)


func check_power_spread(pos: Vector2i) -> void:
	var cell: Cell
	
	if pos in placed_cells:
		cell = placed_cells[pos]
	elif pos in side_cells:
		cell = side_cells[pos]
	else:
		print("Error checking power spread at: ", pos)
		return
	
	if not cell.powered:
		return
	
	for dir in cell.get_connection_dirs():
		if pos + dir in placed_cells:
			var possible_connection: Cell = placed_cells[pos + dir]
			
			if possible_connection.connects_in_dir(-dir) and not possible_connection.powered:
				possible_connection.powered = true
				possible_connection.set_tile(possible_connection.tile)
				
				if (possible_connection.tile in Tiles.LED_TILES 
						and not possible_connection in lit_LEDS):
					lit_LEDS.append(possible_connection)
				
				check_power_spread(pos + dir)
		elif pos + dir in side_cells:
			var possible_connection: Cell = side_cells[pos + dir]
			
			if possible_connection.linked_cell and not possible_connection.powered:
				possible_connection.powered = true
				possible_connection.set_tile(possible_connection.tile)
				
				possible_connection.linked_cell.powered = true
				possible_connection.linked_cell.set_tile(possible_connection.linked_cell.tile)
				
				check_power_spread(possible_connection.linked_cell.board_pos)


func advance() -> void:
	if current_level_index + 1 < len(levels):
		current_level_index += 1
		load_grid()
