extends CharacterBody2D
class_name Player

const SPEED = 300.0

signal switch_dim(player: Player)
signal picked_up_pizza

var current_dim = "B"
@export_enum("Player1", "Player2") var role: String

var controls = {
	"Player1":
		{
			"up": "ui_up",
			"down": "ui_down",
			"right": "ui_right",
			"left": "ui_left",
			"switch": "ui_switch"
		},
	"Player2":
		{
			"up": "ui_up2",
			"down": "ui_down2",
			"right": "ui_right2",
			"left": "ui_left2",
			"switch": "ui_switch2"
		}
}

func _ready() -> void:
	var splitscreen: SplitScreen2D = get_tree().current_scene.get_node("SplitScreen2D")
	connect("switch_dim", splitscreen.switch_dim)
	
	var game_master: GameMaster = get_tree().current_scene
	connect("picked_up_pizza", game_master.picked_up_pizza)

func _physics_process(_delta: float) -> void:
	var direction_x := Input.get_axis(controls.get(role).get("left"), controls.get(role).get("right"))
	var direction_y := Input.get_axis(controls.get(role).get("up"), controls.get(role).get("down"))
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if Input.is_action_just_pressed(controls.get(role).get("switch")):
		swicth_dim()

	move_and_slide()

func swicth_dim():
	emit_signal("switch_dim", self)
