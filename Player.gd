extends "res://Actor.gd"

func after_process():
	$RichTextLabel.bbcode_text  = "[center][color=black]%s[/color][/center]" % current_state

func setup():
	props.type = "Player"
	
func _on_HitArea_body_entered(body):
	if(body == self):
		return
	if(props in body):
		var props = body.props
		if(props.type=="Actor"):
			hit()
		
	pass # Replace with function body.
