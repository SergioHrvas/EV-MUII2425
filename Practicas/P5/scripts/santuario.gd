extends Node

# Definimos las variables
@export var ruta_habitacion1: String = "res://elements/habitacion1.tscn"
@export var ruta_habitacion2: String = "res://elements/habitacion2.tscn"
@export var posicion_habitacion1: Vector3 = Vector3(0, 0, 0)
@export var posicion_habitacion2: Vector3 = Vector3(-29.327, 31.349, 0)

var habitacion1: Node = null
var habitacion2: Node = null
var pasillo: Node = null
var posiciones_iniciales := {}
var estado_habitacion1 = {}
var palanca: StaticBody3D = null
var plataforma_real: AnimatableBody3D = null
var contador_area_1: int = 0
var contador_area_2: int = 0

	
func _ready():
	var label1 = $Start/Label
	var label2 = $Start/Label2
	
	# Reproducir sonido de inicio
	var sound = preload("res://sonidos/init_shrine.ogg")
	var player = AudioStreamPlayer.new()
	player.stream = sound
	add_child(player)
	player.play()

	label1.modulate.a = 0.0
	label2.modulate.a = 0.0
	label1.visible = true
	label2.visible = true
	
	# Creamos el Tween para la animación FadeIn
	var tween_in = create_tween()
	tween_in.parallel().tween_property(label1, "modulate:a", 1.0, 1.0)
	tween_in.parallel().tween_property(label2, "modulate:a", 1.0, 1.0)
	
	# Esperamos 4 segundos
	await get_tree().create_timer(4.0).timeout
	
	# Crear el Tween para la animación FadeOut
	var tween_out = create_tween()
	tween_out.parallel().tween_property(label1, "modulate:a", 0.0, 1.0)
	tween_out.parallel().tween_property(label2, "modulate:a", 0.0, 1.0)
	await tween_out.finished
	
	label1.visible = false
	label2.visible = false
	
	# Definimos nodos
	palanca = $Habitacion1/Palanca/StaticBody3D
	plataforma_real = $Pasillo/Ascensor/Plataforma
	pasillo = $Pasillo
	habitacion1 = $Habitacion1
	habitacion2 = $Habitacion2
	
	# Conectamos la señal con palanca
	palanca.connect("palanca_activada", Callable(plataforma_real, "toggle_move"))

	# Guardamos las posiciones iniciales de las habitaciones
	if habitacion1:
		posiciones_iniciales["habitacion1"] = habitacion1.position
	if habitacion2:
		posiciones_iniciales["habitacion2"] = habitacion2.position
	
	# Comenzamos descargando la habitacion 2 (empezamos en la 1)s
	if habitacion2:
		habitacion2.queue_free()
		habitacion2 = null
		
	$End.visible = false
	
	await player.finished
	player.queue_free()
	

# Funcion para cargar habitacion
func _cargar_habitacion(ruta: String, nombre: String) -> Node:
	var escena = load(ruta)
	if escena:
		# Instanciamos la escena y la ponemos en la posicion inicial
		var instancia = escena.instantiate()
		if nombre in posiciones_iniciales:
			instancia.position = posiciones_iniciales[nombre]
		return instancia
	return null

# Si el jugador entra al area 1
func _on_area_1_body_entered(body):
	if body.name == "Avatar":
		contador_area_1 += 1
		if contador_area_1 == 1:
			# Cargar habitación 1
			if !habitacion1 or !is_instance_valid(habitacion1):
				habitacion1 = _cargar_habitacion(ruta_habitacion1, "habitacion1")
				if habitacion1:
					# 
					add_child(habitacion1)
					habitacion1.global_transform = Transform3D.IDENTITY.translated(posiciones_iniciales["habitacion1"])
					
					palanca = habitacion1.get_node("Palanca/StaticBody3D")
					plataforma_real = $Pasillo/Ascensor/Plataforma
					
					var callable = Callable(plataforma_real, "toggle_move")
					if palanca.is_connected("palanca_activada", callable):
						palanca.disconnect("palanca_activada", callable)
					palanca.connect("palanca_activada", callable)

					call_deferred("_restaurar_estado_habitacion1")
			
			# Descargar habitación 2
			if habitacion2 and is_instance_valid(habitacion2):
				habitacion2.queue_free()
				habitacion2 = null


func _on_area_2_body_entered(body):
	if body.name == "Avatar":
		contador_area_2 += 1
		if contador_area_2 == 1:
			# Cargar habitación 2
			if !habitacion2 or !is_instance_valid(habitacion2):
				habitacion2 = _cargar_habitacion(ruta_habitacion2, "habitacion2")
				if habitacion2:
					add_child(habitacion2)
					habitacion2.global_transform = Transform3D.IDENTITY.translated(posiciones_iniciales["habitacion2"])
			
			# Descargar habitación 1
			if habitacion1 and is_instance_valid(habitacion1):
				for cogible in get_tree().get_nodes_in_group("cogible"):
					if not is_instance_valid(cogible):
						continue  # Saltar si el nodo no es válido
						
					cogible.freeze = true  # Congelar temporalmente para evitar física

					# Guardar posición según el nombre del objeto
					match cogible.name:
						"Bola1":
							estado_habitacion1["pos_bola1"] = cogible.global_transform.origin
						"Bola2":
							estado_habitacion1["pos_bola2"] = cogible.global_transform.origin
						"Gancho":
							estado_habitacion1["pos_gancho"] = cogible.global_transform.origin
							estado_habitacion1["rot_gancho"] = cogible.global_rotation
					
					cogible.freeze = false  # Descongelar

				habitacion1.queue_free()
				habitacion1 = null
				
				
# Si salgo de las areas, cambio contadores
func _on_area_1_body_exited(body):
	if body.name == "Avatar":
		contador_area_1 -= 1
		if contador_area_1 < 0:
			contador_area_1 = 0

func _on_area_2_body_exited(body):
	if body.name == "Avatar":
		contador_area_2 -= 1
		if contador_area_2 < 0:
			contador_area_2 = 0
			
func _restaurar_estado_habitacion1():
	if habitacion1:
		# Restauramos las posiciones de los objetos movibles
		if estado_habitacion1.has("pos_bola1"):
			var bola1 = habitacion1.get_node("Bola1")
			if bola1:
				bola1.freeze = true
				bola1.global_transform.origin = estado_habitacion1["pos_bola1"]
				bola1.freeze = false
		
		if estado_habitacion1.has("pos_bola2"):
			var bola2 = habitacion1.get_node("Bola2")
			if bola2:
				bola2.freeze = true
				bola2.global_transform.origin = estado_habitacion1["pos_bola2"]
				bola2.freeze = false

		if estado_habitacion1.has("pos_gancho"):
			var gancho = habitacion1.get_node("Gancho")
			if gancho:
				gancho.freeze = true
				gancho.global_transform.origin = estado_habitacion1["pos_gancho"]
				gancho.global_rotation = estado_habitacion1["rot_gancho"]

				gancho.freeze = false
