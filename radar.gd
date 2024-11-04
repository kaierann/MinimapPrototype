extends Area2D

var enemy_icon = preload("res://marker.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		$CanvasLayer/RadarUI.add_object(body, enemy_icon)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		$CanvasLayer/RadarUI.update_item(area)
