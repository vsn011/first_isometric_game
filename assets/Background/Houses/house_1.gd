extends StaticBody2D


func _on_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		modulate.a = 0.3


func _on_detector_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		modulate.a = 1
