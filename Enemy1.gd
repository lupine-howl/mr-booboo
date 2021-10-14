extends "res://Actor.gd"
	
var last_tile = -1
var walking_direction = "left"
	
func die ():
	queue_free()
	pass 	
	
func setup():
	controls.direction.x = -1
	pass	
	
#walk
#if hit wall reverse
#if reach ledge reverse
#if hit player jump, then run away
#if being attacked fight back

	
	
func update_controls():
	controls.jump = false
	if(is_on_floor()):
		var raycast = $AnimatedSprite/RayCast2D
		if raycast.is_colliding():
			var hit_collider = raycast.get_collider()
			if hit_collider is TileMap:
				var tilemap = hit_collider
				var hit_pos = raycast.get_collision_point()
				var tile_pos = tilemap.world_to_map(hit_pos)
				last_tile = tilemap.get_cellv(tile_pos)
		else:
			if(last_tile==0):
				controls.jump = true
			elif(last_tile==1):
				controls.direction.x *= -1
			
	pass

func after_process():
	$RichTextLabel.bbcode_text  = "[center][color=black]%s[/color][/center]" % current_state

func _on_HitArea_body_entered(body):
	if(body==self):
		return
	#if(body.get_meta("type")=="Actor"):
	controls.direction.x *= -1
	pass # Replace with function body.
