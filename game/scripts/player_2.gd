extends CharacterBody2D


const SPEED = 300.0


func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("ui_left2", "ui_right2")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
