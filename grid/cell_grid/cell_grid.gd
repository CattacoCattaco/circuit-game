class_name CellGrid
extends GridContainer

@export var cell_scene: PackedScene

@export var grid_size: int = 7

var cells: Array[Cell] = []


func _ready() -> void:
	load_grid()


func load_grid() -> void:
	for cell in cells:
		cell.queue_free()
	
	cells = []
	
	columns = grid_size
	
	for y in range(grid_size):
		for x in range(grid_size):
			var cell: Cell = cell_scene.instantiate()
			
			cell.pos = Vector2i(x, y)
			cell.cell_grid = self
			cell.powered = false
			
			add_child(cell)
			cells.append(cell)
			
			var end: int = grid_size - 1
			var middle: int = end >> 1
			
			match [x, y]:
				[0, 0]:
					cell.set_tile(Vector2i(0, 17))
				[end, 0]:
					cell.set_tile(Vector2i(1, 17))
				[end, end]:
					cell.set_tile(Vector2i(2, 17))
				[0, end]:
					cell.set_tile(Vector2i(3, 17))
				[middle, 0]:
					cell.set_tile(Vector2i(0, 12))
				[middle, end]:
					cell.set_tile(Vector2i(2, 12))
				[0, middle]:
					cell.set_tile(Vector2i(0, 8))
				[end, middle]:
					cell.set_tile(Vector2i(2, 8))
				[_, 0]:
					cell.set_tile(Vector2i(2, 13))
				[_, end]:
					cell.set_tile(Vector2i(3, 13))
				[0, _]:
					cell.set_tile(Vector2i(0, 10))
				[end, _]:
					cell.set_tile(Vector2i(1, 10))
				[_, _]:
					cell.set_tile(Vector2i(0, 0))


func get_cell(x: int, y: int) -> Cell:
	return cells[x + y * grid_size]


func get_cell_by_vec(vec: Vector2i) -> Cell:
	return cells[vec.x + vec.y * grid_size]
