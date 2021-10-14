extends Node

export var settings = {
	"gravity": 100,
	"friction": 0.1,
	"jump_force":1000,
	"walk_force":70,
	"run_force":140
}

export var control_mapping = {
	"left": "ui_left",
	"right": "ui_right",
	"up": "ui_up",
	"down": "ui_down",
	"jump": "ui_accept",
	"attack1": "ui_select"
}

var controls = {
	"direction": Vector2(),
	"left": false,
	"right": false,
	"up": false,
	"down": false,
	"jump": false,
	"attack1": false,
	"attack2": false
}

var state = {
	"direction": Vector2(),
	"velocity": Vector2(),
	"action":{
		"jump": false,
		"walk": false,
		"run": false,
		"fall": false,
		"attack1": false,
		"attack2": false
	},
	"animation": "idle"
}

func update_controls():
	controls.left = Input.is_action_pressed(control_mapping.left)
	controls.right = Input.is_action_pressed(control_mapping.right)
	controls.up = Input.is_action_pressed(control_mapping.up)
	controls.down = Input.is_action_pressed(control_mapping.down)
	controls.jump = Input.is_action_just_pressed(control_mapping.jump)
	controls.attack1 = Input.is_action_just_pressed(control_mapping.attack1)
	if(controls.left):
		controls.direction.x = -1
	elif(controls.right):
		controls.direction.x = 1
	else:
		controls.direction.x = 0
	if(controls.up):
		controls.direction.y = -1
	elif(controls.down):
		controls.direction.y = 1
	else:
		controls.direction.y = 0
	pass
	
func update_actions():
	pass
	
func update_motion():
	pass

func update_animation():
	pass
	
func update_sprite():
	pass

func _ready():
	pass
	
func _process(delta):
	update_controls()
	update_actions()
	update_motion()
	update_sprite()
	pass

func _physics_process(delta):
	pass
