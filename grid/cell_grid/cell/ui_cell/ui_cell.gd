class_name UICell
extends Cell

enum Area {
	TITLE,
	PLAY_BUTTON,
	LEVEL_BUTTON,
	RETURN_TO_MENU_BUTTON,
	TEXT,
	EMPTY,
}

@export var title_texture: Texture

@export var frames: AtlasTexture

var area: Area = Area.EMPTY

var frame: Vector2i

var button_cells: Array[UICell]

var level_num: int


func _ready() -> void:
	super()
	
	set_tile(UITiles.BLANK)
	set_frame(UIFrames.EMPTY)


func set_tile(new_tile_pos: Vector2i, redraw_frame: bool = true) -> void:
	if redraw_frame:
		set_frame(frame, false)
	
	tile = new_tile_pos
	
	if area == Area.TITLE:
		tiles.atlas = title_texture
	elif powered:
		tiles.atlas = preload("res://grid/cell_grid/cell/ui_cell/ui_tiles_powered.png")
	else:
		tiles.atlas = preload("res://grid/cell_grid/cell/ui_cell/ui_tiles_unpowered.png")
	
	tiles.region.position = (tile * 9) as Vector2
	var desired_image: Image = tiles.get_image()
	
	for x in range(9):
		for y in range(9):
			var pixel_color: Color = desired_image.get_pixel(x, y)
			if pixel_color.a != 0:
				set_pixel(x, y, pixel_color)


func set_frame(new_frame_pos: Vector2i, redraw_tile: bool = true) -> void:
	frame = new_frame_pos
	
	if powered:
		tiles.atlas = preload("res://grid/cell_grid/cell/ui_cell/ui_frames_powered.png")
	else:
		tiles.atlas = preload("res://grid/cell_grid/cell/ui_cell/ui_frames_unpowered.png")
	
	frames.region.position = (frame * 9) as Vector2
	var desired_image: Image = frames.get_image()
	
	for x in range(9):
		for y in range(9):
			set_pixel(x, y, desired_image.get_pixel(x, y))
	
	if redraw_tile:
		set_tile(tile, false)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if button_cells:
				for button_cell in button_cells:
					button_cell.powered = true
					button_cell.set_tile(button_cell.tile)
				
				await cell_grid.grid_holder.stall()
				
				match area:
					Area.PLAY_BUTTON:
						cell_grid.grid_holder.open_level_select()
					Area.LEVEL_BUTTON:
						cell_grid.grid_holder.open_level(level_num)
					Area.RETURN_TO_MENU_BUTTON:
						cell_grid.grid_holder.open_title_screen()
