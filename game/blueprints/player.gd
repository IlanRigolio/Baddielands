extends CharacterBody2D

@export_enum("Player1", "Player2") var role = "Player1"

const SPEED = 300
var is_in_b_dim = true
var switch = ""

func _ready() -> void:
	if role == "Player1":
		switch = "p1_switch" # touche E
	else: 
		switch = "p2_switch" # touche 0
	modulate = Color(0.0, 0.41, 0.727, 1.0)

#func _ready() -> void:
	#
	#
func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	if role == "Player1":
		if Input.is_action_pressed("p1_left"): # Q
			direction.x = -1
		if Input.is_action_pressed("p1_right"): # D
			direction.x = 1
		if Input.is_action_pressed("p1_up"): # Z
			direction.y = -1
		if Input.is_action_pressed("p1_down"): # S
			direction.y = 1
	else :
		if Input.is_action_pressed("p2_left"): # fleche gauche
			direction.x = -1
		if Input.is_action_pressed("p2_right"): # fleche droite
			direction.x = 1
		if Input.is_action_pressed("p2_up"): # fleche haut
			direction.y = -1
		if Input.is_action_pressed("p2_down"): # fleche bas
			direction.y = 1
	velocity = direction*SPEED
	
	if Input.is_action_just_pressed(switch):
		is_in_b_dim = !is_in_b_dim
		update_layer()
		
	move_and_slide()
	
func update_layer():
	if is_in_b_dim :
		collision_mask = 2 # collide avec le mur bleu
		modulate = Color(0.0, 0.41, 0.727, 1.0)
	else : 
		if role == "Player1":
			collision_mask = 1 # collide avec le mur vert
			modulate = Color(0.184, 0.553, 0.347, 1.0)
		else:
			collision_mask = 4 # NE PAS CHANGER LES LAYER SONT EN BINAIRE L3 = 4 | collide avec le mer rouge
			modulate = Color(0.845, 0.227, 0.367, 1.0)
