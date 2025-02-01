extends CharacterBody2D

const acceleration := 600
const friction := 400
var input = Vector2.ZERO

@export var speed := 70
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")

var current_state = player_state.MOVE
enum player_state{MOVE, ATTACK, DEAD}

func _process(delta: float) -> void:
	match current_state:
		player_state.MOVE:
			player_movement(delta)
		player_state.ATTACK:
			sword_attack(delta)

func diagonal_movement(diagonal):
	var screen_pos = Vector2()
	screen_pos.x = diagonal.x - diagonal.y
	screen_pos.y = (diagonal.x + diagonal.y) / 2
	return screen_pos
	
func player_input(delta):
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if input != Vector2.ZERO:
		velocity = velocity.limit_length(speed)
		
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	velocity += diagonal_movement(input * acceleration * delta)
	move_and_slide()

func player_movement(delta):
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if input != Vector2.ZERO:
		animation_state()
		anim_state.travel("move")
		velocity = velocity.limit_length(speed)
		
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			anim_state.travel("idle")
			velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_sword"):
		current_state = player_state.ATTACK
			
	velocity += diagonal_movement(input * acceleration * delta)
	move_and_slide()

func sword_attack(delta):
	player_input(delta)
	anim_state.travel("attack")
	
func reset_state():
	current_state = player_state.MOVE

func animation_state():
	anim_tree.set("parameters/idle/blend_position", input)
	anim_tree.set("parameters/move/blend_position", input)
	anim_tree.set("parameters/attack/blend_position", input)

func flash():
	$Sprite2D.material.set_shader_parameter("flash_modifier", 1)
	await get_tree().create_timer(0.3).timeout
	$Sprite2D.material.set_shader_parameter("flash_modifier", 0)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		flash()
