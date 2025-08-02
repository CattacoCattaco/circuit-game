class_name Cell
extends ColorRect

@export var tiles: AtlasTexture
@export var pixel_holder: GridContainer

var pixels: Array[ColorRect] = []

var cell_grid: CellGrid

var powered: bool = false

var pos: Vector2i

var tile: Vector2i


func _ready() -> void:
	gui_input.connect(_on_gui_input)
	
	for i in range(81):
		var new_pixel := ColorRect.new()
		new_pixel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		new_pixel.size_flags_vertical = Control.SIZE_EXPAND_FILL
		new_pixel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
		pixel_holder.add_child(new_pixel)
		pixels.append(new_pixel)


func set_tile(new_tile_pos: Vector2i) -> void:
	tile = new_tile_pos
	
	tiles.region.position = (new_tile_pos * 9) as Vector2
	var desired_image: Image = tiles.get_image()
	
	for x in range(9):
		for y in range(9):
			set_pixel(x, y, desired_image.get_pixel(x, y))


func set_pixel(x: int, y: int, pixel_color: Color) -> void:
	pixels[x + y * 9].color = pixel_color


func _on_gui_input(_event: InputEvent) -> void:
	pass
