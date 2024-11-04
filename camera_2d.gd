extends Camera2D

@onready var player: CharacterBody2D = $"../../../../../Player"
var objects = {}
const ENEMY = preload("res://enemy.png")

func update_map():
	update_position()
	
func update_position():
	self.position = player.position
	$"../Sprite2D".position = player.position
	
	for object in get_tree().get_nodes_in_group("minimap_objects"):
		var new_marker = ENEMY
