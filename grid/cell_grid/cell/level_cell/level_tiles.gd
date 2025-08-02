class_name LevelTiles
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

const CHAR_A := Vector2i(0, 23)
const CHAR_B := Vector2i(1, 23)
const CHAR_C := Vector2i(2, 23)
const CHAR_D := Vector2i(3, 23)
const CHAR_E := Vector2i(0, 24)
const CHAR_F := Vector2i(1, 24)
const CHAR_G := Vector2i(2, 24)
const CHAR_H := Vector2i(3, 24)
const CHAR_I := Vector2i(0, 25)
const CHAR_J := Vector2i(1, 25)
const CHAR_K := Vector2i(2, 25)
const CHAR_L := Vector2i(3, 25)
const CHAR_M := Vector2i(0, 26)
const CHAR_N := Vector2i(1, 26)
const CHAR_O := Vector2i(2, 26)
const CHAR_P := Vector2i(3, 26)
const CHAR_Q := Vector2i(0, 27)
const CHAR_R := Vector2i(1, 27)
const CHAR_S := Vector2i(2, 27)
const CHAR_T := Vector2i(3, 27)
const CHAR_U := Vector2i(0, 28)
const CHAR_V := Vector2i(1, 28)
const CHAR_W := Vector2i(2, 28)
const CHAR_X := Vector2i(3, 28)
const CHAR_Y := Vector2i(0, 29)
const CHAR_Z := Vector2i(1, 29)
const CHAR_PERIOD := Vector2i(2, 29)
const CHAR_COMMA := Vector2i(3, 29)
const CHAR_EXCLAMATION := Vector2i(0, 30)
const CHAR_QUESTION := Vector2i(1, 30)
const CHAR_COLON := Vector2i(2, 30)
const CHAR_SEMICOLON := Vector2i(3, 30)
const CHAR_0 := Vector2i(0, 31)
const CHAR_1 := Vector2i(1, 31)
const CHAR_2 := Vector2i(2, 31)
const CHAR_3 := Vector2i(3, 31)
const CHAR_4 := Vector2i(0, 32)
const CHAR_5 := Vector2i(1, 32)
const CHAR_6 := Vector2i(2, 32)
const CHAR_7 := Vector2i(3, 32)
const CHAR_8 := Vector2i(0, 33)
const CHAR_9 := Vector2i(1, 33)

const CHARS: Array[Vector2i] = [
	CHAR_A,
	CHAR_B,
	CHAR_C,
	CHAR_D,
	CHAR_E,
	CHAR_F,
	CHAR_G,
	CHAR_H,
	CHAR_I,
	CHAR_J,
	CHAR_K,
	CHAR_L,
	CHAR_M,
	CHAR_N,
	CHAR_O,
	CHAR_P,
	CHAR_Q,
	CHAR_R,
	CHAR_S,
	CHAR_T,
	CHAR_U,
	CHAR_V,
	CHAR_W,
	CHAR_X,
	CHAR_Y,
	CHAR_Z,
	CHAR_PERIOD,
	CHAR_COMMA,
	CHAR_EXCLAMATION,
	CHAR_QUESTION,
	CHAR_COLON,
	CHAR_SEMICOLON,
	CHAR_0,
	CHAR_1,
	CHAR_2,
	CHAR_3,
	CHAR_4,
	CHAR_5,
	CHAR_6,
	CHAR_7,
	CHAR_8,
	CHAR_9,
]
const LETTERS: Array[Vector2i] = [
	CHAR_A,
	CHAR_B,
	CHAR_C,
	CHAR_D,
	CHAR_E,
	CHAR_F,
	CHAR_G,
	CHAR_H,
	CHAR_I,
	CHAR_J,
	CHAR_K,
	CHAR_L,
	CHAR_M,
	CHAR_N,
	CHAR_O,
	CHAR_P,
	CHAR_Q,
	CHAR_R,
	CHAR_S,
	CHAR_T,
	CHAR_U,
	CHAR_V,
	CHAR_W,
	CHAR_X,
	CHAR_Y,
	CHAR_Z,
]
const PUNCTUATION: Array[Vector2i] = [
	CHAR_PERIOD,
	CHAR_COMMA,
	CHAR_EXCLAMATION,
	CHAR_QUESTION,
	CHAR_COLON,
	CHAR_SEMICOLON,
]
const DIGITS: Array[Vector2i] = [
	CHAR_0,
	CHAR_1,
	CHAR_2,
	CHAR_3,
	CHAR_4,
	CHAR_5,
	CHAR_6,
	CHAR_7,
	CHAR_8,
	CHAR_9,
]
