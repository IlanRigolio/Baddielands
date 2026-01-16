extends Area2D
class_name Hole

@export var id: int
@export var jump_out_point: Vector2 = global_position

func find_destination():
	var nodes = get_node("..").get_children()
	for node in nodes:
		if node is Hole:
			if node.id == id:
				return node


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var dest = find_destination()
		if dest != null:
			body.fall(dest)
