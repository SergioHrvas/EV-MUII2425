extends CharacterBody3D
		
func _on_test_activar_avatar() -> void:
	$Pivot/Pitch/Camera3D.current = true


@export var speed := 5.0
@export var jump_velocity := 5.0
@export var mouse_sensitivity := 0.002
@onready var ray = $Pivot/Pitch/Camera3D/RayCast3D

var gravity := 9.8
var objeto_agarrado: RigidBody3D = null

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
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	# Gravedad y salto
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
	
	if objeto_agarrado:
		var cam = $Pivot/Pitch/Camera3D
		var target_transform = cam.global_transform.translated(Vector3(0, 0, -2))
		objeto_agarrado.global_transform = target_transform

	move_and_slide()
	  
	if Input.is_action_just_pressed("interactuar") and ray.is_colliding():
			var obj = ray.get_collider()
			if obj.has_method("activar"):
				obj.activar()
							
			if objeto_agarrado:
				soltar_objeto()
			else:
				print("aa")
				intentar_agarrar()
				
	# Empujar RigidBody3D al colisionar caminando
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody3D:
			var push_dir = -collision.get_normal()
			push_dir.y = 0  # No empujar hacia arriba/abajo
			push_dir = push_dir.normalized()

			var force = push_dir * speed * 0.3
			collider.apply_central_impulse(force)


func intentar_agarrar():
	var ray = $Pivot/Pitch/Camera3D/RayCast3D
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider is RigidBody3D and collider.name == "Bola":
			print("Agarrando pelota")
			objeto_agarrado = collider
			objeto_agarrado.freeze = true
			$Pivot/Pitch/Camera3D.add_child(objeto_agarrado)
			# Posicionar el objeto frente a la cámara en coordenadas globales
			var cam = $Pivot/Pitch/Camera3D
			objeto_agarrado.global_transform = cam.global_transform.translated(Vector3(0, 0, -1.5))


func soltar_objeto():
	print("Soltando pelota")
	objeto_agarrado.freeze = false
	get_parent().add_child(objeto_agarrado)
	objeto_agarrado.global_transform = $Pivot/Pitch/Camera3D.global_transform.translated(Vector3(0, 0, -1.5))
	objeto_agarrado = null
