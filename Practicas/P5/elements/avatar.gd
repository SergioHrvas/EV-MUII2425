extends CharacterBody3D
		
func _on_test_activar_avatar() -> void:
	$Pivot/Pitch/Camera3D.current = true


@export var speed := 5.0
@export var jump_velocity := 6.0
@export var mouse_sensitivity := 0.002
@onready var ray = $Pivot/Pitch/Camera3D/RayCast3D

var gravity := 9.8

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot/Pitch.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot/Pitch.rotation.x = clamp($Pivot/Pitch.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta):
	var pivot_basis = $Pivot.global_transform.basis

	var direction = Vector3.ZERO
	if Input.is_action_pressed("delante"):
		direction -= pivot_basis.z
	if Input.is_action_pressed("atras"):
		direction += pivot_basis.z
	if Input.is_action_pressed("izquierda"):
		direction -= pivot_basis.x
	if Input.is_action_pressed("derecha"):
		direction += pivot_basis.x
	direction = direction.normalized()

	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	move_and_slide()  

   # Empujar RigidBody3D después de moverte
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody3D:
			# Calcula la dirección de empuje basada en el movimiento del jugador
			var push_force = velocity  # Ajusta el multiplicador
			collider.apply_central_impulse(push_force * delta)
		
	if Input.is_action_just_pressed("interactuar"):
		if ray.is_colliding():
			var obj = ray.get_collider()
			if obj.has_method("activar"):
				obj.activar()
