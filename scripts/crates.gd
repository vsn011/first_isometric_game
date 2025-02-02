extends StaticBody2D

@onready var coin_loot = preload("res://assets/Interactables/Coin/coins.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Sword"):
		$anim.play("Destroyed")
		on_coin_loot()
		await $anim.animation_finished
		queue_free()

func on_coin_loot():
	var coin = coin_loot.instantiate()
	coin.position = global_position
	get_tree().get_root().add_child(coin)
