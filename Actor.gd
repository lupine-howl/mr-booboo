extends KinematicBody2D

var velocity = Vector2.ZERO
export  (Vector2) var max_speed = Vector2(120,370)
export  (Vector2) var acceleration = Vector2(70,50)
export var default_scale : int = 1
export var gravity = 30
export var friction = 0.7
var current_state = "idle"

#controls, action, animation

var controls = {
	"direction": Vector2.ZERO,
	"left": 0,
	"right": 0,
	"up": 0,
	"down": 0,
	"jump": false,
	"attack1": false,
	"attack2": false
}

func update_controls():
	state.direction.x = 0
	controls.left = Input.is_action_pressed("ui_left")
	controls.right = Input.is_action_pressed("ui_right")
	controls.up = Input.is_action_pressed("ui_up")
	controls.down = Input.is_action_pressed("ui_down")
	controls.jump = Input.is_action_just_pressed("ui_accept")
	controls.attack1 = Input.is_action_just_pressed("ui_select")
	if(controls.left):
		controls.direction.x = -1
	elif(controls.right):
		controls.direction.x = 1
	else:
		controls.direction.x = 0

func set_state(new_state):
	current_state = new_state
	pass

func update_idle():
	if(is_on_floor()):
		if(controls.jump):
			state.direction.y = -1
			set_state("jumping")
		if(controls.direction.x!=0):
			set_state("walking")
			state.direction.x = controls.direction.x
			
	else:
		set_state("falling")
	pass
	
func update_walking():
	if(is_on_floor()):
		if(controls.jump):
			state.direction.y = -1
			set_state("jumping")
		if(controls.direction.x!=0):
			set_state("walking")
			state.direction.x = controls.direction.x
		else:
			set_state("idle")
			state.direction.x = 0
			
	elif(velocity.y<0):
		set_state("jumping")
	else:
		set_state("falling")
	pass
	
func update_jumping():
	state.direction.y = 0
	
	if(controls.direction.x!=0):
		state.direction.x = controls.direction.x
		
	if(is_on_floor()):
		set_state("idle")
	
	if(controls.jump):
		state.direction.y = -1
		set_state("falling")
	if(velocity.y>=0):
		set_state("falling")

			
func update_falling():
	state.direction.y = 0
	if(controls.direction.x!=0):
		state.direction.x = controls.direction.x		
	if(is_on_floor()):
		set_state("idle")

var states = {
	"jump":{
		"update_func": "update_jump"
	}
}

var state = {
	"animation": "idle",
	"motion": "idle",
	"jump": "idle",
	"attack": "idle",
	"direction": Vector2()
}

var props = {
	"type": "Actor"
}

func hit():
	state.motion = "hit"
	get_tree().create_timer(1)
	pass

func setup():
	pass

func _ready():
	setup()
	pass

func die():
	yield(get_tree().create_timer(1), "timeout")
	get_tree().reload_current_scene()
	
func update_motion_state():
	
	if(Input.is_action_pressed("ui_left")):
		state.direction.x = -1
	elif(Input.is_action_pressed("ui_right")):
		state.direction.x = 1
	else:
		state.direction.x = 0
	
	if(is_on_floor()):
		state.motion = "idle"
		if(Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right")):
			state.motion = "walk"
		if(Input.is_action_just_pressed("ui_accept")):
			state.motion = "jump"
			
	elif(state.motion != "jumping"):
		state.motion = "falling"
			
	if(state.motion == "jumping" && Input.is_action_just_pressed("ui_accept")):
		state.motion = "double_jump"
		

func update_velocity():
	velocity.x += acceleration.x * state.direction.x
	#velocity.x = clamp(velocity.x, -max_speed.x, max_speed.x)
	if(is_on_floor()):
		velocity.y = 1
		
		
	var wall_slide_adjustment = 1
	if(state.direction.y<0):
		velocity.y = max_speed.y * state.direction.y
		state.direction.y = 0
	
	#elif(velocity.y > 0 && is_on_wall()):
	#	wall_slide_adjustment = 0
	
	velocity.y += (gravity*wall_slide_adjustment)
		
		
	if(velocity.x > -1 && velocity.x < 1):
		velocity.x = 0
	else:
		velocity.x *= friction
	
	
	if(velocity.y>1000):
		die()
	after_update_velocity()
	
func after_update_velocity():
	pass
	
func after_update_animation():
	pass
	
func update_animation():
	var new_animation = "idle"
	
	if(!is_on_floor()):
		new_animation = "jump"
	elif(current_state == "walking"):
		new_animation = "move"
		
	if(velocity.x < 0):
		$AnimatedSprite.scale.x = -1*default_scale
	elif(velocity.x > 0):
		$AnimatedSprite.scale.x = 1*default_scale
		
	if(new_animation!=state.animation):
		state.animation = new_animation
		$AnimatedSprite.play(state.animation)
				
	after_update_animation()
	pass

func after_process():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_controls()
	var state_update_func_name = "update_"+current_state
	call(state_update_func_name)
	update_velocity()
	update_animation()
	move_and_slide(velocity, Vector2.UP)
	after_process()
	pass
