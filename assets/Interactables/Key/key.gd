extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_data.key += 1
		print(player_data.key)
		$anim.play("collected")
		await $anim.animation_finished
		queue_free()
