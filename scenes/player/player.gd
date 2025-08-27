class_name Player
extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = -400.0

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	velocity.x = speed
	
	if GameState.won:
		velocity = Vector2.ZERO

	move_and_slide()

func _process(_delta: float) -> void:
	if velocity.is_zero_approx():
		sprite_2d.play("idle")
	elif is_on_floor():
		sprite_2d.play("running")
	elif velocity.y < 0:
		sprite_2d.play("jumping")
	elif velocity.y > 0:
		sprite_2d.play("falling")
