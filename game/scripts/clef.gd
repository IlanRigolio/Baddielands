extends Area2D
class_name Clef

@export_enum("A", "B", "C") var dim: String = "A"
@export var key_id: String = "clef_1"

func _ready() -> void:
	match dim:
		"A":
			add_to_group("A")
			collision_layer = 1
			collision_mask = 1
			modulate = Color(1, 0.6, 0.6)
		"B":
			add_to_group("B")
			collision_layer = 2
			collision_mask = 2
			modulate = Color(0.6, 1, 0.6) 
		"C":
			add_to_group("C")
			collision_layer = 4
			collision_mask = 4
			modulate = Color(0.6, 0.6, 1)

	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.pickup_key(key_id)
		print("Clef ramassée : " + key_id)
		queue_free()
