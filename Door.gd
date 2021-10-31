extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var leads_to = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func open(body):
	print(body.name)
	if(body.name=="Player"):
		get_tree().change_scene("res://levels/"+leads_to+".tscn")

	pass # Replace with function body.
