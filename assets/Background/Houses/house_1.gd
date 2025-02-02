extends StaticBody2D

var player_entered = false

func _on_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		modulate.a = 0.3


func _on_detector_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		modulate.a = 1

func _input(event: InputEvent) -> void:
	if player_entered == true && player_data.key >= 1:
		if Input.is_action_just_pressed("ui_interact"):
			print("E is pressed")
			$anim.play("Opened")
			player_data.key -= 1

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_data.player_position = body.position
		player_entered = true
		$door_label.visible = true


func _on_player_detector_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("Player"):
		player_entered = false
		$door_label.visible = false


func _on_change_level_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://scenes/level_2.tscn") # Replace with function body.
