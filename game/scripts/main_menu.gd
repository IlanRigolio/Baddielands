extends Control

func _ready():
	$PlayButton.pressed.connect(_on_play_pressed)
	$QuitButton.pressed.connect(_on_quit_pressed)

func _on_play_pressed():
	GameManager.start_game()

func _on_quit_pressed():
	get_tree().quit()
