extends CanvasLayer

@onready var label = $PanelContainer/MarginContainer/RichTextLabel

func show_message(text_content: String):
	$PanelContainer.visible = true
	label.text = text_content
	label.visible_ratio = 0.0
	var tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, 2.0)
	await get_tree().create_timer(3.0).timeout
	queue_free()
