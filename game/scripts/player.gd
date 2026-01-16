extends CharacterBody2D
class_name Player

const SPEED = 300.0

signal switch_dim(player: Player)
signal picked_up_pizza

var current_dim = "B"
@export_enum("Player1", "Player2") var role: String
var inventory: Array[String] = []
@export var clef_scene: PackedScene

var controls = {
	"Player1":
		{
			"up": "ui_up",
			"down": "ui_down",
			"right": "ui_right",
			"left": "ui_left",
			"switch": "ui_switch",
			"drop": "ui_drop"
		},
	"Player2":
		{
			"up": "ui_up2",
			"down": "ui_down2",
			"right": "ui_right2",
			"left": "ui_left2",
			"switch": "ui_switch2",
			"drop": "ui_drop2"
		}
}

@onready var animation: AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	var splitscreen: SplitScreen2D = get_tree().current_scene.get_node("SplitScreen2D")
	connect("switch_dim", splitscreen.switch_dim)

func _physics_process(_delta: float) -> void:
	if get_tree().paused:
		return
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

	update_animation()
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	var action_switch = controls.get(role).get("switch")
	var action_drop = controls.get(role).get("drop")
	if event.is_action_pressed(action_switch):
		swicth_dim()
	if event.is_action_pressed(action_drop):
		drop_key()

func swicth_dim():
	show_message("Vous changez de dimension !")
	emit_signal("switch_dim", self)

func pickup_key(key_id: String)->bool:
	if inventory.size() >= 1:
		var key_inventory = inventory[0]
		show_message("Vous portez déjà : " + "[color=yellow]" + key_inventory + "[/color]" + " ! Impossible de récupérer " + "[color=yellow]" + key_id + "[/color]")
		return false
	else:
		inventory.append(key_id)
		print(role + " a ramassé : " + key_id)
		show_message("Vous avez ramassé :\n" + "[color=yellow]" + key_id + "[/color]")
		return true

func has_key(key_id: String) -> bool:
	return key_id in inventory

func use_key(key_id: String):
	if has_key(key_id):
		inventory.erase(key_id)
		
func drop_key():
	if inventory.is_empty():
		return
	if clef_scene == null: 
		return
	var split = get_tree().current_scene.find_child("SplitScreen2D", true, false)
	if not split:
		return
	var key_dropped = inventory[-1]
	use_key(key_dropped)
	var new_key = clef_scene.instantiate()
	new_key.key_id = key_dropped
	new_key.dim = current_dim
	if split.level:
		split.level.add_child(new_key)
	else:
		get_parent().add_child(new_key)
	new_key.set_as_top_level(true)
	new_key.global_position = global_position + Vector2(0, 70) # Il faut mettre la clef plus bas sinon on la recupère instant
	print(role + " a jeté : " + key_dropped + " en Dim " + current_dim)
	show_message("Vous avez jeté :\n" + "[color=yellow]" + key_dropped + "[/color]")
	# pour gerer la visibilité ça marchait pas godot chargeait pas la clef alors je freeze
	await get_tree().process_frame
	split.update_objects_visibility(self)

@export var dialog_scene: PackedScene

func show_message(text: String):
	var split = get_tree().current_scene.find_child("SplitScreen2D", true, false)
	var my_camera = split.get_player_camera(self)
	var box = dialog_scene.instantiate()
	var panel = box.get_node("PanelContainer")
	my_camera.get_parent().add_child(box)
	panel.visibility_layer = 3
	panel.get_node("MarginContainer").visibility_layer = 3
	panel.get_node("MarginContainer/RichTextLabel").visibility_layer = 3
	panel.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
	panel.position.y -= 20
	box.show_message(text)

func update_animation():
	if velocity.length() == 0:
		animation.pause()
		return
	if role == "Player1":
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				play_anim("right")
			else:
				play_anim("left")
		else:
			if velocity.y > 0:
				play_anim("down")
			else:
				play_anim("up")
	else:
		if velocity.y > 0:
			play_anim("down")
		elif velocity.y < 0:
			play_anim("up")
		if animation.current_animation != "down" and animation.current_animation != "up":
			play_anim("down")

func play_anim(animation_name: String):
	if animation.has_animation(animation_name):
		animation.play(animation_name)
