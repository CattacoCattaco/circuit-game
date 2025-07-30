class_name GridHolder
extends Control

@export var timer: Timer
@export var cell_grid: CellGrid


func _ready() -> void:
	cell_grid.load_grid()
