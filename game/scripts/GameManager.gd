extends Node

var time_elapsed: float = 0.0
var is_game_running: bool = false

func _process(delta: float) -> void:
	if is_game_running:
		time_elapsed += delta

func start_game():
	time_elapsed = 0.0
	is_game_running = true
	get_tree().change_scene_to_file("res://scenes/node_2d.tscn")

func stop_game():
	is_game_running = false

func get_time_string() -> String:
	var minutes = int(time_elapsed / 60)
	var seconds = int(time_elapsed) % 60
	var msecs = int((time_elapsed - int(time_elapsed)) * 100)
	return "%02d:%02d:%02d" % [minutes, seconds, msecs]
