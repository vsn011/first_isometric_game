extends Node2D

@onready var key_scene = preload("res://assets/Interactables/Key/key.tscn")
@onready var key_spawn: Marker2D = $"../key_spawn"
signal on_enemy_dead_all

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	on_enemy_dead()
	
func on_enemy_dead():
	if get_child_count() == 0:
		emit_signal("on_enemy_dead_all")
		
		
func on_key_loot():
	var key = key_scene.instantiate()
	key.position = key_spawn.global_position
	get_tree().get_root().add_child(key)


func _on_on_enemy_dead_all() -> void:
	set_block_signals(true)
	on_key_loot()
