extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HitArea_body_entered(body):
	if(body.name == "Player"):
		body.state.direction.y = -1
		body.set_state("jumping")
		body.velocity.y = -20
	pass # Replace with function body.
