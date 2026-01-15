extends Area2D

@export_enum("A", "C") var dim: String = "A"
@export var key_id: String = "clef_1"
@onready var sprite_pizza = $SpritePizza

const ferme_A = "res://assets/coffre/coffre_bleu.png"
const ferme_C = "res://assets/coffre/coffre_rouge.png"
const ouvert = "res://assets/coffre/coffre_gris.png"
@onready var zone_detection = $Detection

func _ready() -> void:
	match dim:
		"A":
			add_to_group("A")
			collision_layer = 1
			collision_mask = 1
			$Sprite2D.texture = load(ferme_A)
		"C":
			add_to_group("C")
			collision_layer = 4
			collision_mask = 4
			$Sprite2D.texture = load(ferme_C)
			
	zone_detection.collision_layer = 7
	zone_detection.collision_mask = 7
	zone_detection.body_entered.connect(_on_zone_entered)

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
			if dim == "A":
				$Sprite2D.texture = load(ferme_A)
			elif dim == "C":
				$Sprite2D.texture = load(ferme_C)
			body.use_key(key_id)
			animer_pizza()
			set_deferred("monitoring", false)
			$Sprite2D.texture = load(ouvert)
			return
		if body.inventory[0] != self.key_id:
			body.show_message("Vous n'avez pas la bonne " + "[color=yellow]" + "clef" + "[/color]" + " !")
			return
			
func _on_zone_entered(body: Node2D) -> void:
	if body is Player:
		if not body.is_in_group(dim):
			body.show_message("Il semble y avoir quelque chose ici ...")
			return
			
func animer_pizza():
	sprite_pizza.visible = true
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(sprite_pizza, "position:y", sprite_pizza.position.y - 50, 1.0)
	tween.tween_property(sprite_pizza, "scale", Vector2(1.5, 1.5), 0.5)
	tween.tween_property(sprite_pizza, "modulate:a", 0.0, 1.0)
	await get_tree().create_timer(1.0).timeout
	
	print("Pizza récoltée !")
	sprite_pizza.queue_free() 
