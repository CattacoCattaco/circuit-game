class_name UICellGrid
extends CellGrid

enum Context {
	TITLE_SCREEN,
	LEVEL_SELECT
}

var context: Context = Context.TITLE_SCREEN


func load_grid() -> void:
	match context:
		Context.TITLE_SCREEN:
			grid_size = 24
		Context.LEVEL_SELECT:
			grid_size = 16
	
	super()
	
	var current_level: int = 0
	
	var current_button: Array[UICell] = []
	
	for y in range(grid_size):
		for x in range(grid_size):
			var cell: UICell = cell_scene.instantiate()
			
			cell.pos = Vector2i(x, y)
			cell.cell_grid = self
			
			add_child(cell)
			cells.append(cell)
			
			if context == Context.TITLE_SCREEN:
				if x >= 2 and x < 22 and y >= 2 and y < 10:
					cell.area = UICell.Area.TITLE
					cell.set_tile(Vector2i(x - 2, y - 2))
				else:
					match [x, y]:
						[9, 13]:
							cell.set_frame(UIFrames.BUTTON_LEFT)
							current_button.append(cell)
						[10, 13]:
							cell.set_frame(UIFrames.BUTTON_MID)
							cell.set_tile(UITiles.CHAR_P)
							current_button.append(cell)
						[11, 13]:
							cell.set_frame(UIFrames.BUTTON_MID)
							cell.set_tile(UITiles.CHAR_L)
							current_button.append(cell)
						[12, 13]:
							cell.set_frame(UIFrames.BUTTON_MID)
							cell.set_tile(UITiles.CHAR_A)
							current_button.append(cell)
						[13, 13]:
							cell.set_frame(UIFrames.BUTTON_MID)
							cell.set_tile(UITiles.CHAR_Y)
							current_button.append(cell)
						[14, 13]:
							cell.set_frame(UIFrames.BUTTON_RIGHT)
							current_button.append(cell)
							for button_cell in current_button:
								button_cell.area = UICell.Area.PLAY_BUTTON
								button_cell.button_cells = current_button
							
							current_button = []
						_:
							cell.set_tile(UITiles.BLANK)
			elif context == Context.LEVEL_SELECT:
				if y > 2 and y % 2 == 1 and len(grid_holder.level_grid.levels) > current_level:
					match x % 3:
						0:
							cell.set_tile(UITiles.BLANK)
						1:
							@warning_ignore("integer_division")
							var first_digit: int = (current_level - (current_level % 10)) / 10
							cell.set_tile(UITiles.LEFT_LEVEL_DIGITS[first_digit])
							cell.set_frame(UIFrames.BUTTON_LEFT)
							current_button.append(cell)
						2:
							cell.set_tile(UITiles.RIGHT_LEVEL_DIGITS[current_level % 10])
							cell.set_frame(UIFrames.BUTTON_RIGHT)
							current_button.append(cell)
							
							for button_cell in current_button:
								button_cell.level_num = current_level
								button_cell.area = UICell.Area.LEVEL_BUTTON
								button_cell.button_cells = current_button
							
							current_button = []
							
							current_level += 1
				else:
					match [x, y]:
						[1, 1]:
							cell.set_tile(UITiles.LEFT_ARROW)
							cell.area = UICell.Area.RETURN_TO_MENU_BUTTON
							cell.button_cells = [cell]
						[5, 1]:
							cell.set_tile(UITiles.CHAR_L)
							cell.area = UICell.Area.TEXT
							cell.powered = true
						[6, 1]:
							cell.set_tile(UITiles.CHAR_E)
							cell.area = UICell.Area.TEXT
							cell.powered = true
						[7, 1]:
							cell.set_tile(UITiles.CHAR_V)
							cell.area = UICell.Area.TEXT
							cell.powered = true
						[8, 1]:
							cell.set_tile(UITiles.CHAR_E)
							cell.area = UICell.Area.TEXT
							cell.powered = true
						[9, 1]:
							cell.set_tile(UITiles.CHAR_L)
							cell.area = UICell.Area.TEXT
							cell.powered = true
						[10, 1]:
							cell.set_tile(UITiles.CHAR_S)
							cell.area = UICell.Area.TEXT
							cell.powered = true
						_:
							cell.set_tile(UITiles.BLANK)
