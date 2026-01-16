extends StaticBody2D
class_name Boulder

@export var id: int = 0
@export var dest: Vector2 = global_position

@onready var origine: Vector2 = global_position

var SPEED = 200.0
var activated_plates: int:
	set(value):
		activated_plates = value
		if activated_plates == 0:
			come_back()
		else:
			move()

func move():
	var tween = create_tween()
	tween.tween_property(self, "global_position", dest, Vector2(origine - dest).length() / SPEED)

func come_back():
	var tween = create_tween()
	tween.tween_property(self, "global_position", origine, Vector2(dest - origine).length() / SPEED)
