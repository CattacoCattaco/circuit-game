class_name UITiles
extends RefCounted

const CHAR_A := Vector2i(0, 0)
const CHAR_B := Vector2i(1, 0)
const CHAR_C := Vector2i(2, 0)
const CHAR_D := Vector2i(3, 0)
const CHAR_E := Vector2i(4, 0)
const CHAR_F := Vector2i(5, 0)
const CHAR_G := Vector2i(6, 0)
const CHAR_H := Vector2i(7, 0)
const CHAR_I := Vector2i(0, 1)
const CHAR_J := Vector2i(1, 1)
const CHAR_K := Vector2i(2, 1)
const CHAR_L := Vector2i(3, 1)
const CHAR_M := Vector2i(4, 1)
const CHAR_N := Vector2i(5, 1)
const CHAR_O := Vector2i(6, 1)
const CHAR_P := Vector2i(7, 1)
const CHAR_Q := Vector2i(0, 2)
const CHAR_R := Vector2i(1, 2)
const CHAR_S := Vector2i(2, 2)
const CHAR_T := Vector2i(3, 2)
const CHAR_U := Vector2i(4, 2)
const CHAR_V := Vector2i(5, 2)
const CHAR_W := Vector2i(6, 2)
const CHAR_X := Vector2i(7, 2)
const CHAR_Y := Vector2i(0, 3)
const CHAR_Z := Vector2i(1, 3)
const CHAR_PERIOD := Vector2i(2, 3)
const CHAR_COMMA := Vector2i(3, 3)
const CHAR_EXCLAMATION := Vector2i(4, 3)
const CHAR_QUESTION := Vector2i(5, 3)
const CHAR_COLON := Vector2i(6, 3)
const CHAR_SEMICOLON := Vector2i(7, 3)
const CHAR_0 := Vector2i(0, 4)
const CHAR_1 := Vector2i(1, 4)
const CHAR_2 := Vector2i(2, 4)
const CHAR_3 := Vector2i(3, 4)
const CHAR_4 := Vector2i(4, 4)
const CHAR_5 := Vector2i(5, 4)
const CHAR_6 := Vector2i(6, 4)
const CHAR_7 := Vector2i(7, 4)
const CHAR_8 := Vector2i(0, 5)
const CHAR_9 := Vector2i(1, 5)

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

const BLANK := Vector2i(2, 5)

const CHECK := Vector2i(3, 5)

const LEFT_LEVEL_0 := Vector2i(4, 5)
const LEFT_LEVEL_1 := Vector2i(5, 5)
const LEFT_LEVEL_2 := Vector2i(6, 5)
const LEFT_LEVEL_3 := Vector2i(7, 5)
const LEFT_LEVEL_4 := Vector2i(0, 6)
const LEFT_LEVEL_5 := Vector2i(1, 6)
const LEFT_LEVEL_6 := Vector2i(2, 6)
const LEFT_LEVEL_7 := Vector2i(3, 6)
const LEFT_LEVEL_8 := Vector2i(4, 6)
const LEFT_LEVEL_9 := Vector2i(5, 6)

const LEFT_LEVEL_DIGITS: Array[Vector2i] = [
	LEFT_LEVEL_0,
	LEFT_LEVEL_1,
	LEFT_LEVEL_2,
	LEFT_LEVEL_3,
	LEFT_LEVEL_4,
	LEFT_LEVEL_5,
	LEFT_LEVEL_6,
	LEFT_LEVEL_7,
	LEFT_LEVEL_8,
	LEFT_LEVEL_9,
]

const RIGHT_LEVEL_0 := Vector2i(6, 6)
const RIGHT_LEVEL_1 := Vector2i(7, 6)
const RIGHT_LEVEL_2 := Vector2i(0, 7)
const RIGHT_LEVEL_3 := Vector2i(1, 7)
const RIGHT_LEVEL_4 := Vector2i(2, 7)
const RIGHT_LEVEL_5 := Vector2i(3, 7)
const RIGHT_LEVEL_6 := Vector2i(4, 7)
const RIGHT_LEVEL_7 := Vector2i(5, 7)
const RIGHT_LEVEL_8 := Vector2i(6, 7)
const RIGHT_LEVEL_9 := Vector2i(7, 7)

const RIGHT_LEVEL_DIGITS: Array[Vector2i] = [
	RIGHT_LEVEL_0,
	RIGHT_LEVEL_1,
	RIGHT_LEVEL_2,
	RIGHT_LEVEL_3,
	RIGHT_LEVEL_4,
	RIGHT_LEVEL_5,
	RIGHT_LEVEL_6,
	RIGHT_LEVEL_7,
	RIGHT_LEVEL_8,
	RIGHT_LEVEL_9,
]

const LEFT_ARROW := Vector2i(0, 8)
const RIGHT_ARROW := Vector2i(1, 8)
