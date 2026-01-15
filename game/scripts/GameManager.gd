extends Node

var time_elapsed = 0.0
var is_game_running  = 0
var pizza_count = 0
var pizza_win = 3 

func _process(delta: float) -> void:
	if is_game_running:
		time_elapsed += delta
	if Input.is_action_just_pressed("ui_cheat"):
		win_game()

func start_game():
	time_elapsed = 0.0
	is_game_running = true
	pizza_count = 0
	get_tree().change_scene_to_file("res://scenes/node_2d.tscn")

func stop_game():
	is_game_running = false

func get_time_string() -> String:
	var minutes = int(time_elapsed / 60)
	var seconds = int(time_elapsed) % 60
	var msecs = int((time_elapsed - int(time_elapsed)) * 100)
	return "%02d:%02d:%02d" % [minutes, seconds, msecs]

func picked_up_pizza(body : Node2D):
	pizza_count += 1
	if body is Player:
		body.show_message("Vous avez trouvé une pizza !")
	if pizza_count >= pizza_win:
		win_game()
		
func win_game():
	get_tree().change_scene_to_file("res://scenes/Win.tscn")
