extends StaticBody2D

@export var transparency:float = 0.3
@export var opaque:float = 1.0

func _on_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		modulate.a = transparency


func _on_detector_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		modulate.a = opaque
