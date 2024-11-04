extends CharacterBody2D

@export var speed = 400
var tween

func _ready() -> void:
	$Radar/CanvasLayer/RadarUI.player = self
	
func _input(event):
	if event.is_action_pressed("update"):
		tween = create_tween()
		$Radar/CanvasLayer/RadarUI/Radar/SensorRotation.visible = true
		tween.tween_property($Radar/CanvasLayer/RadarUI/Radar/SensorRotation, "rotation", deg_to_rad(720), 5)
		#$Radar/CanvasLayer/RadarUI.update_items()
		await tween.finished
		$Radar/CanvasLayer/RadarUI/Radar/SensorRotation.rotation = 0
		$Radar/CanvasLayer/RadarUI/Radar/SensorRotation.visible = false

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
