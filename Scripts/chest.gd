extends Area2D

signal collected(value)

func _on_area_entered(area: Area2D) -> void:
	$Sprite2D.visible = false
	collected.emit(1)


func _on_area_exited(area: Area2D) -> void:
	$Sprite2D.visible = true
