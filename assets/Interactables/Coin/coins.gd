extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_data.coin_number +=1
		$anim.play("Collected")
		await $anim.animation_finished
		queue_free()
