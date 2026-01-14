extends Area2D
class_name Pizza

@export_enum("A", "B", "C") var dim: String = "B"

func _ready() -> void:
	match dim:
		"A":
			collision_layer = 9
			collision_mask = 9
		"B":
			collision_layer = 18
			collision_mask = 18
		"C":
			collision_layer = 36
			collision_mask = 36

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.emit_signal("picked_up_pizza")
		queue_free()
