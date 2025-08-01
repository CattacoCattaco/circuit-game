class_name GridHolder
extends Control

@export var timer: Timer
@export var cell_grid: CellGrid


func _ready() -> void:
	var i: int = 0
	while true:
		var path: String = "res://levels/level_%s.tres" % i
		if not ResourceLoader.exists(path):
			break
		
		cell_grid.levels.append(load(path))
		
		i += 1
	
	cell_grid.levels.append(load("res://levels/level_end.tres"))
	
	cell_grid.load_grid()
