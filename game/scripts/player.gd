extends CharacterBody2D
class_name Player

const SPEED = 300.0

signal switch_dim(player: Player)

enum Dimension {A, B, C}

@export var unique_dimension: Dimension
@export var common_dimension: Dimension

func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func swicth_dim():
	emit_signal("switch_dim", [self])
