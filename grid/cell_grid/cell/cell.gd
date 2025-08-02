class_name Cell
extends ColorRect

enum Area {
	BOARD_CELLS,
	BOARD_SIDES,
	PLACEABLES,
	PLACEABLE_ARROWS,
	SUBMIT_CHECK,
	EMPTY,
}

@export var tiles: AtlasTexture
@export var frames: AtlasTexture
@export var pixel_holder: GridContainer

var pixels: Array[ColorRect] = []

var cell_grid: CellGrid

var powered: bool = false

var board_pos: Vector2i
var area: Area

var tile: Vector2i
var frame: Vector2i

var linked_cell: Cell


func _ready() -> void:
	gui_input.connect(_on_gui_input)
	
	for i in range(81):
		var new_pixel := ColorRect.new()
		new_pixel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		new_pixel.size_flags_vertical = Control.SIZE_EXPAND_FILL
		new_pixel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
		pixel_holder.add_child(new_pixel)
		pixels.append(new_pixel)
	
	set_tile(Tiles.EMPTY_CELL)
	set_frame(Frames.EMPTY)


func set_tile(new_tile_pos: Vector2i, redraw_frame: bool = true) -> void:
	tile = new_tile_pos
	
	if is_power_source():
		powered = true
	
	if powered:
		tiles.atlas = preload("res://grid/cell_grid/cell/tiles_powered.png")
	else:
		tiles.atlas = preload("res://grid/cell_grid/cell/tiles_unpowered.png")
	
	tiles.region.position = (new_tile_pos * 9) as Vector2
	var desired_image: Image = tiles.get_image()
	
	for x in range(9):
		for y in range(9):
			set_pixel(x, y, desired_image.get_pixel(x, y))
	
	if redraw_frame:
		set_frame(frame, false)


func set_frame(new_frame_pos: Vector2i, redraw_tile: bool = true) -> void:
	frame = new_frame_pos
	
	if redraw_tile:
		set_tile(tile, false)
	
	frames.region.position = (new_frame_pos * 9) as Vector2
	var desired_image: Image = frames.get_image()
	
	for x in range(9):
		for y in range(9):
			var pixel_color: Color = desired_image.get_pixel(x, y)
			if pixel_color.a != 0:
				set_pixel(x, y, pixel_color)


func set_pixel(x: int, y: int, pixel_color: Color) -> void:
	pixels[x + y * 9].color = pixel_color


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if area == Area.PLACEABLES:
				if tile == Tiles.EMPTY_CELL:
					return
				
				if frame == Frames.EMPTY:
					select()
				else:
					cell_grid.selected_placeable_cell = null
					deselect()
			elif area == Area.BOARD_CELLS:
				if cell_grid.selected_placeable_cell and tile == Tiles.EMPTY_CELL:
					cell_grid.placed_cells[board_pos] = self
					set_tile(cell_grid.selected_placeable_cell.tile)
					cell_grid.remove_placeable_cell(cell_grid.selected_placeable_cell)
					cell_grid.check_power()
			elif area == Area.PLACEABLE_ARROWS:
				powered = true
				set_tile(tile)
				
				if tile == Tiles.LEFT_ARROW:
					cell_grid.prev_placeable_page()
				elif tile == Tiles.RIGHT_ARROW:
					cell_grid.next_placeable_page()
			elif area == Area.SUBMIT_CHECK:
				if powered:
					cell_grid.advance()
		elif event.button_index == MOUSE_BUTTON_LEFT and (event.canceled or not event.pressed):
			if area == Area.PLACEABLE_ARROWS:
				powered = false
				set_tile(tile)
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if area == Area.BOARD_CELLS:
				if tile == Tiles.EMPTY_CELL or frame == Frames.FORCED:
					return
				else:
					cell_grid.placed_cells.erase(board_pos)
					cell_grid.add_tile_to_placeables(tile)
					set_tile(Tiles.EMPTY_CELL)
					powered = false
					cell_grid.check_power(true)


func select() -> void:
	if cell_grid.selected_placeable_cell:
		cell_grid.selected_placeable_cell.deselect()
	
	cell_grid.selected_placeable_cell = self
	set_frame(Frames.SELECTED)


func deselect() -> void:
	set_frame(Frames.EMPTY)


func is_power_source() -> bool:
	return tile in Tiles.BATTERY_TILES


func connects_in_dir(dir: Vector2i) -> bool:
	return dir in get_connection_dirs()


func get_connection_dirs() -> Array[Vector2i]:
	match tile:
		Tiles.EMPTY_CELL, Tiles.BLOCK:
			return []
		Tiles.L_BATTERY, Tiles.L_LED:
			return [Vector2i(-1, 0)]
		Tiles.T_BATTERY, Tiles.T_LED:
			return [Vector2i(0, -1)]
		Tiles.R_BATTERY, Tiles.R_LED:
			return [Vector2i(1, 0)]
		Tiles.B_BATTERY, Tiles.B_LED:
			return [Vector2i(0, 1)]
		Tiles.TB_STRAIGHT, Tiles.TB_LED:
			return [Vector2i(0, -1), Vector2i(0, 1)]
		Tiles.LR_STRAIGHT, Tiles.LR_LED:
			return [Vector2i(-1, 0), Vector2i(1, 0)]
		Tiles.TL_CORNER, Tiles.TL_LED:
			return [Vector2i(-1, 0), Vector2i(0, -1)]
		Tiles.TR_CORNER, Tiles.TR_LED:
			return [Vector2i(1, 0), Vector2i(0, -1)]
		Tiles.BR_CORNER, Tiles.BR_LED:
			return [Vector2i(1, 0), Vector2i(0, 1)]
		Tiles.BL_CORNER, Tiles.BL_LED:
			return [Vector2i(-1, 0), Vector2i(0, 1)]
		Tiles.NON_B_TEE:
			return [Vector2i(-1, 0), Vector2i(0, -1), Vector2i(1, 0)]
		Tiles.NON_L_TEE:
			return [Vector2i(0, -1), Vector2i(1, 0), Vector2i(0, 1)]
		Tiles.NON_T_TEE:
			return [Vector2i(-1, 0), Vector2i(0, 1), Vector2i(1, 0)]
		Tiles.NON_R_TEE:
			return [Vector2i(0, -1), Vector2i(-1, 0), Vector2i(0, 1)]
		Tiles.ALL_BATTERY, Tiles.ALL_LED, Tiles.ALL_WIRE:
			return [Vector2i(-1, 0), Vector2i(0, -1), Vector2i(1, 0), Vector2i(0, 1)]
	
	if tile in Tiles.POWERABLE_TOP_SIDES:
		return [Vector2i(0, 1)]
	elif tile in Tiles.POWERABLE_LEFT_SIDES:
		return [Vector2i(1, 0)]
	elif tile in Tiles.POWERABLE_BOTTOM_SIDES:
		return [Vector2i(0, -1)]
	elif tile in Tiles.POWERABLE_RIGHT_SIDES:
		return [Vector2i(-1, 0)]
	
	return []
