extends Area2D
class_name Pizza

@export_enum("A", "B", "C") var dim: String = "B"

func _ready() -> void:
	match dim:
		"A":
			add_to_group("A")
			collision_layer = 1
			collision_mask = 1
			modulate = Color(1, 0, 0, 1)
		"B":
			add_to_group("B")
			collision_layer = 2
			collision_mask = 2
			modulate = Color(0, 1, 0, 1)
		"C":
			add_to_group("C")
			collision_layer = 4
			collision_mask = 4
			modulate = Color(0, 0, 1, 1)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.emit_signal("picked_up_pizza")
		queue_free()
