extends Button

func _ready():
	pivot_offset = size / 2
	mouse_entered.connect(_on_hover)
	mouse_exited.connect(_on_exit)
	focus_entered.connect(_on_hover)
	focus_exited.connect(_on_exit)

func _gui_input(event):

	if event.is_action_pressed("ui_switch") or event.is_action_pressed("ui_switch2"):
		pressed.emit()
		accept_event()
		
func _on_hover():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1)

func _on_exit():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
