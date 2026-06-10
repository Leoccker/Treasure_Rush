extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("invert_gravity"):
		GravityManager.toggle()

	var grav_mult := 1.0
	var jump_dir := 1.0
	if GravityManager.inverted:
		up_direction = Vector2(0, 1)
		grav_mult = -1.0
		jump_dir = -1.0
	else:
		up_direction = Vector2(0, -1)
		grav_mult = 1.0
		jump_dir = 1.0

	if not is_on_floor():
		velocity += get_gravity() * delta * grav_mult

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY * jump_dir

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody2D:
			var body = collision.get_collider()
			body.apply_central_impulse(-collision.get_normal() * 200)
