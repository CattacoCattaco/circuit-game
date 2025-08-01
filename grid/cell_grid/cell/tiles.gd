class_name Tiles
extends RefCounted

const LR_STRAIGHT := Vector2i(0, 0)
const TB_STRAIGHT := Vector2i(1, 0)

const TL_CORNER := Vector2i(0, 1)
const TR_CORNER := Vector2i(1, 1)
const BR_CORNER := Vector2i(2, 1)
const BL_CORNER := Vector2i(3, 1)

const NON_B_TEE := Vector2i(0, 2)
const NON_L_TEE := Vector2i(1, 2)
const NON_T_TEE := Vector2i(2, 2)
const NON_R_TEE := Vector2i(3, 2)

const L_BATTERY := Vector2i(0, 3)
const T_BATTERY := Vector2i(1, 3)
const R_BATTERY := Vector2i(2, 3)
const B_BATTERY := Vector2i(3, 3)

const ALL_BATTERY := Vector2i(0, 4)

const BATTERY_TILES: Array[Vector2i] = [
	L_BATTERY,
	T_BATTERY,
	R_BATTERY,
	B_BATTERY,
	ALL_BATTERY,
]

const ALL_LED := Vector2i(1, 4)
const LR_LED := Vector2i(2, 4)
const TB_LED := Vector2i(3, 4)

const L_LED := Vector2i(0, 5)
const T_LED := Vector2i(1, 5)
const R_LED := Vector2i(2, 5)
const B_LED := Vector2i(3, 5)

const TL_LED := Vector2i(0, 6)
const TR_LED := Vector2i(1, 6)
const BR_LED := Vector2i(2, 6)
const BL_LED := Vector2i(3, 6)

const LED_TILES: Array[Vector2i] = [
	L_LED,
	T_LED,
	R_LED,
	B_LED,
	LR_LED,
	TB_LED,
	TL_LED,
	TR_LED,
	BR_LED,
	BL_LED,
	ALL_LED,
]

const ALL_WIRE := Vector2i(0, 7)
const BLOCK := Vector2i(1, 7)
const EMPTY_CELL := Vector2i(2, 7)
const BLANK := Vector2i(3, 7)

const BLUE_SIDE_ROW: int = 10
const RED_SIDE_ROW: int = 13
const GREY_SIDE_ROW: int = 14

const POWERABLE_TOP_SIDES: Array[Vector2i] = [
	Vector2i(0, 8),
	Vector2i(0, 9),
	Vector2i(0, 10),
	Vector2i(0, 11),
	Vector2i(0, 12),
	Vector2i(0, 13),
]

const POWERABLE_LEFT_SIDES: Array[Vector2i] = [
	Vector2i(1, 8),
	Vector2i(1, 9),
	Vector2i(1, 10),
	Vector2i(1, 11),
	Vector2i(1, 12),
	Vector2i(1, 13),
]

const POWERABLE_BOTTOM_SIDES: Array[Vector2i] = [
	Vector2i(2, 8),
	Vector2i(2, 9),
	Vector2i(2, 10),
	Vector2i(2, 11),
	Vector2i(2, 12),
	Vector2i(2, 13),
]

const POWERABLE_RIGHT_SIDES: Array[Vector2i] = [
	Vector2i(3, 8),
	Vector2i(3, 9),
	Vector2i(3, 10),
	Vector2i(3, 11),
	Vector2i(3, 12),
	Vector2i(3, 13),
]

const BLUE_BLUE_CORNER_ROW: int = 15
const BLUE_RED_CORNER_ROW: int = 16
const RED_BLUE_CORNER_ROW: int = 17
const RED_RED_CORNER_ROW: int = 18
const GREY_GREY_CORNER_ROW: int = 19
const GREY_RED_CORNER_ROW: int = 20
const RED_GREY_CORNER_ROW: int = 21

const LEFT_ARROW := Vector2i(0, 22)
const RIGHT_ARROW := Vector2i(1, 22)

const SUBMIT_CHECK := Vector2i(2, 22)
