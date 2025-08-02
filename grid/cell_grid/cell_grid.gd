class_name CellGrid
extends GridContainer

@export var grid_holder: GridHolder

@export var cell_scene: PackedScene

var cells: Array[Cell] = []

var grid_size: int


func load_grid() -> void:
	unload_grid()
	
	columns = grid_size


func unload_grid() -> void:
	for cell in cells:
		cell.queue_free()
	
	cells = []


func get_cell(x: int, y: int) -> Cell:
	return cells[x + y * grid_size]


func get_cell_by_vec(vec: Vector2i) -> Cell:
	return cells[vec.x + vec.y * grid_size]
