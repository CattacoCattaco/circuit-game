class_name LevelCell
extends Cell

enum Area {
	BOARD_CELLS,
	BOARD_SIDES,
	PLACEABLES,
	PLACEABLE_ARROWS,
	SUBMIT_CHECK,
	LEVEL_INDICATOR,
	LEVEL_SELECT_ARROW,
	EMPTY,
}

@export var frames: AtlasTexture

var area: Area

var frame: Vector2i

var linked_cell: LevelCell


func _ready() -> void:
	super()
	
	set_tile(LevelTiles.EMPTY_CELL)
	set_frame(Frames.EMPTY)


func set_tile(new_tile_pos: Vector2i, redraw_frame: bool = true) -> void:
	if is_power_source():
		powered = true
	
	if powered:
		tiles.atlas = preload("res://grid/cell_grid/cell/level_cell/tiles_powered.png")
	else:
		tiles.atlas = preload("res://grid/cell_grid/cell/level_cell/tiles_unpowered.png")
	
	super(new_tile_pos)
	
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
				if tile == LevelTiles.EMPTY_CELL:
					return
				
				if frame == Frames.EMPTY:
					select()
				else:
					cell_grid.selected_placeable_cell = null
					deselect()
			elif area == Area.BOARD_CELLS:
				if cell_grid.selected_placeable_cell and tile == LevelTiles.EMPTY_CELL:
					cell_grid.placed_cells[pos] = self
					set_tile(cell_grid.selected_placeable_cell.tile)
					cell_grid.remove_placeable_cell(cell_grid.selected_placeable_cell)
					cell_grid.check_power()
			elif area == Area.PLACEABLE_ARROWS:
				powered = true
				set_tile(tile)
				
				if tile == LevelTiles.LEFT_ARROW:
					cell_grid.prev_placeable_page()
				elif tile == LevelTiles.RIGHT_ARROW:
					cell_grid.next_placeable_page()
			elif area == Area.LEVEL_SELECT_ARROW:
				powered = true
				set_tile(tile)
				
				await cell_grid.grid_holder.stall()
				
				cell_grid.grid_holder.open_level_select()
			elif area == Area.SUBMIT_CHECK:
				if powered:
					cell_grid.advance()
		elif event.button_index == MOUSE_BUTTON_LEFT and (event.canceled or not event.pressed):
			if area == Area.PLACEABLE_ARROWS:
				powered = false
				set_tile(tile)
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if area == Area.BOARD_CELLS:
				if tile == LevelTiles.EMPTY_CELL or frame == Frames.FORCED:
					return
				else:
					cell_grid.placed_cells.erase(pos)
					cell_grid.add_tile_to_placeables(tile)
					set_tile(LevelTiles.EMPTY_CELL)
					powered = false
					
					if self in cell_grid.lit_LEDS:
						cell_grid.lit_LEDS.erase(self)
					elif self in cell_grid.lit_evil_LEDS:
						cell_grid.lit_evil_LEDS.erase(self)
					
					cell_grid.check_power(true)


func select() -> void:
	if cell_grid.selected_placeable_cell:
		cell_grid.selected_placeable_cell.deselect()
	
	cell_grid.selected_placeable_cell = self
	set_frame(Frames.SELECTED)


func deselect() -> void:
	set_frame(Frames.EMPTY)


func is_power_source() -> bool:
	return tile in LevelTiles.BATTERY_TILES


func connects_in_dir(dir: Vector2i) -> bool:
	return dir in get_connection_dirs()


func get_connection_dirs() -> Array[Vector2i]:
	match tile:
		LevelTiles.EMPTY_CELL, LevelTiles.BLOCK:
			return []
		LevelTiles.L_BATTERY, LevelTiles.L_LED, LevelTiles.L_EVIL_LED:
			return [Vector2i(-1, 0)]
		LevelTiles.T_BATTERY, LevelTiles.T_LED, LevelTiles.T_EVIL_LED:
			return [Vector2i(0, -1)]
		LevelTiles.R_BATTERY, LevelTiles.R_LED, LevelTiles.R_EVIL_LED:
			return [Vector2i(1, 0)]
		LevelTiles.B_BATTERY, LevelTiles.B_LED, LevelTiles.B_EVIL_LED:
			return [Vector2i(0, 1)]
		LevelTiles.TB_STRAIGHT, LevelTiles.TB_LED, LevelTiles.TB_EVIL_LED:
			return [Vector2i(0, -1), Vector2i(0, 1)]
		LevelTiles.LR_STRAIGHT, LevelTiles.LR_LED, LevelTiles.LR_EVIL_LED:
			return [Vector2i(-1, 0), Vector2i(1, 0)]
		LevelTiles.TL_CORNER, LevelTiles.TL_LED, LevelTiles.TL_EVIL_LED:
			return [Vector2i(-1, 0), Vector2i(0, -1)]
		LevelTiles.TR_CORNER, LevelTiles.TR_LED, LevelTiles.TR_EVIL_LED:
			return [Vector2i(1, 0), Vector2i(0, -1)]
		LevelTiles.BR_CORNER, LevelTiles.BR_LED, LevelTiles.BR_EVIL_LED:
			return [Vector2i(1, 0), Vector2i(0, 1)]
		LevelTiles.BL_CORNER, LevelTiles.BL_LED, LevelTiles.BL_EVIL_LED:
			return [Vector2i(-1, 0), Vector2i(0, 1)]
		LevelTiles.NON_B_TEE:
			return [Vector2i(-1, 0), Vector2i(0, -1), Vector2i(1, 0)]
		LevelTiles.NON_L_TEE:
			return [Vector2i(0, -1), Vector2i(1, 0), Vector2i(0, 1)]
		LevelTiles.NON_T_TEE:
			return [Vector2i(-1, 0), Vector2i(0, 1), Vector2i(1, 0)]
		LevelTiles.NON_R_TEE:
			return [Vector2i(0, -1), Vector2i(-1, 0), Vector2i(0, 1)]
		LevelTiles.ALL_BATTERY, LevelTiles.ALL_LED, LevelTiles.ALL_EVIL_LED, LevelTiles.ALL_WIRE:
			return [Vector2i(-1, 0), Vector2i(0, -1), Vector2i(1, 0), Vector2i(0, 1)]
	
	if tile in LevelTiles.POWERABLE_TOP_SIDES:
		return [Vector2i(0, 1)]
	elif tile in LevelTiles.POWERABLE_LEFT_SIDES:
		return [Vector2i(1, 0)]
	elif tile in LevelTiles.POWERABLE_BOTTOM_SIDES:
		return [Vector2i(0, -1)]
	elif tile in LevelTiles.POWERABLE_RIGHT_SIDES:
		return [Vector2i(-1, 0)]
	
	return []
