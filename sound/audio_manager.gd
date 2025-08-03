class_name AudioManager
extends Node

@export var timer: Timer
@export var success_player: AudioStreamPlayer
@export var fail_player: AudioStreamPlayer
@export var track_players: Array[AudioStreamPlayer]


func _ready() -> void:
	for track_player in track_players:
		track_player.finished.connect(start_timer)
	
	timer.timeout.connect(play_track)
	
	play_track()


func play_success_sound() -> void:
	success_player.play()


func play_fail_sound() -> void:
	fail_player.play()


func play_track() -> void:
	var track_player: AudioStreamPlayer = track_players.pick_random()
	track_player.play()


func start_timer() -> void:
	var time: float = randf_range(15, 200)
	timer.start(time)
