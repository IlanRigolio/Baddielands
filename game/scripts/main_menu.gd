extends Control

func _ready():
	$PlayButton.pressed.connect(_on_play_pressed)
	$QuitButton.pressed.connect(_on_quit_pressed)
	update_besttime()
	$PlayButton.grab_focus()
	
func update_besttime():
	if GameManager.best_time == 0.0:
		$meilleur_tps.text = "Meilleur Temps : --:--:--"
	else:
		var texte_temps = GameManager.format_time(GameManager.best_time)
		$meilleur_tps.text = "Meilleur Temps : " + texte_temps

func _on_play_pressed():
	GameManager.start_game()

func _on_quit_pressed():
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("ui_reset_score"): 
		GameManager.best_time = 0.0
		GameManager.save_score()
		update_besttime()
