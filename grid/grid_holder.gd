class_name GridHolder
extends Control

@export var level_grid: LevelCellGrid
@export var ui_grid: UICellGrid
@export var audio_manager: AudioManager
@export var stall_timer: Timer


func _ready() -> void:
	var i: int = 0
	while true:
		var path: String = "res://levels/level_%s.tres" % i
		if not ResourceLoader.exists(path):
			break
		
		level_grid.levels.append(load(path))
		
		i += 1
	
	level_grid.levels.append(load("res://levels/level_end.tres"))
	
	open_title_screen()


func stall() -> void:
	stall_timer.start()
	await stall_timer.timeout


func open_level(level_num: int) -> void:
	ui_grid.hide()
	level_grid.show()
	level_grid.current_level_index = level_num
	level_grid.load_grid()


func open_title_screen() -> void:
	level_grid.hide()
	ui_grid.context = UICellGrid.Context.TITLE_SCREEN
	ui_grid.show()
	ui_grid.load_grid()


func open_level_select() -> void:
	level_grid.hide()
	ui_grid.context = UICellGrid.Context.LEVEL_SELECT
	ui_grid.show()
	ui_grid.load_grid()
