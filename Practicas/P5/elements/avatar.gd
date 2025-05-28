extends CharacterBody3D

func _on_test_activar_avatar() -> void:
	$Pivot/Pitch/Camera3D.current = true

@export var speed := 5.0
@export var jump_velocity := 5.0
@export var mouse_sensitivity := 0.002
@onready var ray = $Pivot/Pitch/Camera3D/RayCast3D

var gravity := 9.8
var objeto_agarrado: RigidBody3D = null
var objeto_seg: RigidBody3D = null
var padre_original: Node = null
var grab_distance := 2.0  # Distancia a la que se agarra el objeto

# Offset en local (X = derecha, Y = abajo, Z = hacia adelante negativo)
var offset_local := Vector3(0.5, -0.5, -grab_distance)

var col_layer_guardado := 0
var col_mask_guardado := 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot/Pitch.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot/Pitch.rotation.x = clamp($Pivot/Pitch.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta):
	var pivot_basis = $Pivot.global_transform.basis

	# Movimiento del personaje
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
	
	
	# Mover objeto agarrado
	if objeto_agarrado:
		var cam = $Pivot/Pitch/Camera3D

		# Convertimos el offset local a espacio global
		var offset_global = cam.global_transform.basis * offset_local
		var target_position = cam.global_position + offset_global

		objeto_agarrado.global_transform.origin = target_position
		objeto_agarrado.global_transform.basis = cam.global_transform.basis


	move_and_slide()
	  
	if Input.is_action_just_pressed("interactuar"):

						
		if objeto_agarrado:
			soltar_objeto()
		else:
			if(ray.is_colliding()):
				var obj = ray.get_collider()
				if obj.has_method("activar"):
					obj.activar()
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
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider is RigidBody3D and collider.name.begins_with("Bola"):
			print("Agarrando pelota")
			objeto_agarrado = collider
			objeto_agarrado.freeze = true
			# Guardamos el estado de colisión original
			col_layer_guardado = objeto_agarrado.collision_layer
			col_mask_guardado = objeto_agarrado.collision_mask

			objeto_agarrado.collision_layer = 0
			objeto_agarrado.collision_mask = 0
			# Desactivamos colisiones mientras está agarrado
			objeto_agarrado.collision_layer = 0
			objeto_agarrado.collision_mask = 0

func soltar_objeto():
	if objeto_agarrado:
		print("Soltando pelota")
		# Restauramos las colisiones
		objeto_agarrado.collision_layer = col_layer_guardado
		objeto_agarrado.collision_mask = col_mask_guardado
		objeto_agarrado.freeze = false

		# Dirección de lanzamiento (frente a la cámara)
		var cam = $Pivot/Pitch/Camera3D
		var forward = -cam.global_transform.basis.z.normalized()

		# Calculamos el impulso: velocidad del jugador + impulso hacia adelante
		var impulso = forward * 4.0 + velocity * 0.5
		objeto_agarrado.apply_central_impulse(impulso)

		objeto_seg = objeto_agarrado
		objeto_agarrado = null
