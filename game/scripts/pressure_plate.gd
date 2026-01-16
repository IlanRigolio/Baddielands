extends Area2D
class_name PressurePlate

@export var id: int = 0
@export_enum("A", "B", "C") var dim: String = "B"

@onready var animation: AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	match dim:
		"A":
			add_to_group("A")
			collision_layer = 1
			collision_mask = 1
			visibility_layer = 0
			$Sprite2D.visibility_layer = 0
		"B":
			add_to_group("B")
			collision_layer = 2
			collision_mask = 2
			visibility_layer = 3
			$Sprite2D.visibility_layer = 3
		"C":
			add_to_group("C")
			collision_layer = 4
			collision_mask = 4
			visibility_layer = 0
			$Sprite2D.visibility_layer = 0

func find_boulder():
	var objects = get_node("..").get_children()
	for obj in objects:
		if obj is Boulder:
			if obj.id == id:
				return obj

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animation.play("down")
		var boulder = find_boulder()
		if boulder != null:
			boulder.activated_plates += 1


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		animation.play("up")
		var boulder = find_boulder()
		if boulder != null:
				boulder.activated_plates -= 1
		
