extends Node2D

var TileableObjects = {
	"Player": preload("res://Player.tscn"),
	"Coin": preload("res://Coin.tscn"),
	"Ghost": preload("res://Ghost.tscn"),
	"Pumpkin": preload("res://Pumpkin.tscn")
}

func _ready():
	var t = $TileMap
	var cells = t.get_used_cells()
	for cell_coords in cells:
		var tile_id = t.get_cellv(cell_coords)
		var tile_name = t.tile_set.tile_get_name(tile_id)
		if(tile_name[0]=="="):
			tile_name = tile_name.lstrip("=")
			if(tile_name in TileableObjects):
				var new_item = TileableObjects[tile_name].instance()
				if(new_item != null):
					new_item.position = t.map_to_world(cell_coords)
					new_item.position.y -= 4
					add_child(new_item)
					t.set_cellv(cell_coords, -1)			
			
	pass
