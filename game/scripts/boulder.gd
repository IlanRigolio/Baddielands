extends StaticBody2D
class_name Boulder

@export var id: int = 0
@export var dest: Vector2 = global_position

var SPEED = 200.0
var has_moved: bool = false

func move():
	has_moved = true
	var tween = create_tween()
	tween.tween_property(self, "global_position", dest, Vector2(global_position - dest).length() / SPEED)
