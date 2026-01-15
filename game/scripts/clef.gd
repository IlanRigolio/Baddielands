extends Area2D
class_name Clef

@export_enum("A", "B", "C") var dim: String = "A"
@export var key_id: String = "clef_1"
const clef_A = "res://assets/coffre/clef_bleue.png"
const clef_B = "res://assets/coffre/clef_verte.png"
const clef_C = "res://assets/coffre/clef_rouge.png"
@onready var zone_detection = $Detection

func _ready() -> void:
	match dim:
		"A":
			add_to_group("A")
			collision_layer = 1
			collision_mask = 1
			$Sprite2D.texture = load(clef_A)
		"B":
			add_to_group("B")
			collision_layer = 2
			collision_mask = 2
			$Sprite2D.texture = load(clef_B)
		"C":
			add_to_group("C")
			collision_layer = 4
			collision_mask = 4
			$Sprite2D.texture = load(clef_C)

	body_entered.connect(_on_body_entered)
	zone_detection.collision_layer = 7
	zone_detection.collision_mask = 7
	zone_detection.body_entered.connect(_on_zone_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var succes = body.pickup_key(key_id)
		if succes:
			print("Clef ramassée : " + key_id)
			queue_free()
			
func _on_zone_entered(body: Node2D) -> void:
	if body is Player:
		if not body.is_in_group(dim):
			body.show_message("Il semble y avoir quelque chose ici ...")
			return
