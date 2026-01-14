extends Area2D

@export_enum("A", "C") var dim: String = "A"
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
		if body.inventory.is_empty():
			body.show_message("Vous n'avez aucune " + "[color=yellow]" + "clef" + "[/color]" + " ...")
			return
		if body.inventory[0] == self.key_id:
			body.show_message("Ouverture du " + "[color=yellow]" + "coffre" + "[/color]" + " !")
			await get_tree().create_timer(1.5).timeout
			body.show_message("[color=yellow]" + "Coffre" + "[/color]" + " ouvert !")
			$Sprite2D.texture = load("res://assets/coffre/Wooden Chest 3 - frame  04.png")
			body.use_key(key_id)
			return
		if body.inventory[0] != self.key_id:
			body.show_message("Vous n'avez pas la bonne " + "[color=yellow]" + "clef" + "[/color]" + " !")
			return
