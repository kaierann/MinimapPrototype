extends MarginContainer

var objects = {}
var player = null
var player_position = Vector2.ZERO
@export var zoom_size = Vector2(100, 100) # This sets the center of the radar
@export var zoom_scale = (100.0 / 805.0)
@export var radar_radius = 120.0 # Set this to the radius of your circular radar HUD

func add_object(object, scene):
	var marker = scene.instantiate()
	marker.visible = false
	$Radar.call_deferred("add_child", marker)
	objects[object] = marker
	objects[object].position = (object.position - player_position) * zoom_scale + zoom_size
	
func update_item(object_marker):
	# Find the key that has the given value (object_marker)
	var object_key = null
	for key in objects.keys():
		if objects[key] == object_marker:
			object_key = key
			break

	if object_key == null:
		return  # If key not found, exit the function

	# Proceed with the rest of the code using `object_key`
	if is_instance_valid(object_key):
		var distance_to_center = (object_key.position - player_position).length() * zoom_scale
		if distance_to_center > radar_radius:
			objects[object_key].visible = false
		else:
			objects[object_key].visible = true
		objects[object_key].position = (object_key.position - player_position) * zoom_scale + zoom_size

		if (object_key.position - player_position).length() > 4096:
			remove_object(object_key)
	else:
		remove_object(object_key)

	
func update_items():
	for object in objects.keys():
		if is_instance_valid(object):
			var distance_to_center = (object.position - player_position).length() * zoom_scale
			if distance_to_center > radar_radius:
				objects[object].visible = false
			else:
				objects[object].visible = true
			objects[object].position = (object.position - player_position) * zoom_scale + zoom_size
			
			if (object.position - player_position).length() > 4096:
				remove_object(object)
		else:
			remove_object(object)

func _physics_process(delta: float) -> void:
	$Radar/Player.position = zoom_size
	player_position = player.position

func remove_object(object):
	objects[object].queue_free()
	objects.erase(object)
