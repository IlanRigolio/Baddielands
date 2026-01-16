extends Node

var time_elapsed = 0.0
var is_game_running  = 0
var pizza_count = 0
var pizza_win = 4
var best_time = 0.0
const SAUVEGARDE = "user://savegame.save"

func _ready() -> void:
	load_score()

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
	
func format_time(t: float) -> String:
	var minutes = int(t / 60)
	var seconds = int(t) % 60
	return "%02d:%02d" % [minutes, seconds]

func get_time_string() -> String:
	return format_time(time_elapsed)

func picked_up_pizza(body : Node2D):
	pizza_count += 1
	if body is Player:
		body.show_message("Vous avez trouvé une pizza !")
	if pizza_count >= pizza_win:
		win_game()
		
func win_game():
	stop_game()
	check_high_score()
	get_tree().change_scene_to_file("res://scenes/Win.tscn")
	
func check_high_score():
	if best_time <= 0.0 or time_elapsed < best_time:
		best_time = time_elapsed
		save_score()
		
func save_score():
	var file = FileAccess.open(SAUVEGARDE, FileAccess.WRITE)
	if file == null:
		print("ERREUR CRITIQUE : Impossible de créer le fichier de sauvegarde !")
		print(FileAccess.get_open_error())
		return
	file.store_float(best_time)
	file.close()
	print("Sauvegarde réussie !")

func load_score():
	if FileAccess.file_exists(SAUVEGARDE):
		var file = FileAccess.open(SAUVEGARDE, FileAccess.READ)
		best_time = file.get_float()
		file.close()
	else:
		best_time = 0.0
