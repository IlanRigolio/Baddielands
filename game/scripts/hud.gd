extends CanvasLayer

@onready var timer_label = $timer
@onready var pause_menu = $pause
@onready var pause_music = $pause/AudioStreamPlayer

func _ready():
	pause_menu.visible = false
	$pause/ResumeButton.pressed.connect(_on_resume_button_pressed)
	$pause/MenuButton.pressed.connect(_on_menu_button_pressed)

func _process(delta):
	timer_label.text = GameManager.get_time_string()
	
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	var is_paused = not get_tree().paused
	get_tree().paused = is_paused
	pause_menu.visible = is_paused
	if pause_music:
		pause_music.stream_paused = not is_paused
		if is_paused:
			$pause/ResumeButton.grab_focus()
			if not pause_music.playing: 
				pause_music.play()

func _on_resume_button_pressed():
	toggle_pause()

func _on_menu_button_pressed():
	toggle_pause() 
	GameManager.stop_game()
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
