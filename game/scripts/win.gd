extends Control

@onready var final_time_label = $tpsfinal

func _ready():
	GameManager.stop_game()
	final_time_label.text = "Temps final : " + GameManager.get_time_string()
	if has_node("PlayButton"):
		$PlayButton.text = "REJOUER"
		$PlayButton.pressed.connect(_on_replay_pressed)
	if has_node("QuitButton"):
		$QuitButton.pressed.connect(_on_quit_pressed)
		
func _on_replay_pressed():
	GameManager.start_game()
	
func _on_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
