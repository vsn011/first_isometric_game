extends CharacterBody2D

const acceleration := 600
const friction := 400
var input = Vector2.ZERO

@export var speed := 70

func _process(delta: float) -> void:
	player_movement(delta)

func diagonal_movement(diagonal):
	var screen_pos = Vector2()
	screen_pos.x = diagonal.x - diagonal.y
	screen_pos.y = (diagonal.x + diagonal.y) / 2
	return screen_pos

func player_movement(delta):
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
