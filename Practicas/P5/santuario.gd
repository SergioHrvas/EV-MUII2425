extends Node

@export var ruta_habitacion1: String = "res://elements/habitacion1.tscn"
@export var ruta_habitacion2: String = "res://elements/habitacion2.tscn"
@export var posicion_habitacion1: Vector3 = Vector3(0, 0, 0)  
@export var posicion_habitacion2: Vector3 = Vector3(-29.327, 31.349, 0) 

var habitacion1: Node = null
var habitacion2: Node = null
var pasillo: Node = null
var posiciones_iniciales := {}

func _ready():
	var palanca = $Habitacion1/Palanca/StaticBody3D
	var plataforma_real = $Pasillo/Ascensor/Plataforma
	
	palanca.connect("palanca_activada", Callable(plataforma_real, "toggle_move"))


	# Cargar las instancias iniciales
	pasillo = $Pasillo
	habitacion1 = $Habitacion1
	habitacion2 = $Habitacion2
	
	# Guardar posiciones iniciales
	if habitacion1:
		posiciones_iniciales["habitacion1"] = habitacion1.position
	if habitacion2:
		posiciones_iniciales["habitacion2"] = habitacion2.position
	
	
	# Estado inicial
	if habitacion2:
		habitacion2.queue_free()
		habitacion2 = null

func _cargar_habitacion(ruta: String, nombre: String) -> Node:
	var escena = load(ruta)
	if escena:
		var instancia = escena.instantiate()
		# Establecer posición basada en la posición inicial guardada
		if nombre in posiciones_iniciales:
			instancia.position = posiciones_iniciales[nombre]
		return instancia
	return null

func _on_area_1_body_entered(body):
	if body.name == "Avatar":
		# Cargar habitación 1 si no existe
		if !habitacion1 or !is_instance_valid(habitacion1):
			habitacion1 = _cargar_habitacion(ruta_habitacion1, "habitacion1")
			if habitacion1:
				add_child(habitacion1)
				habitacion1.global_transform = Transform3D.IDENTITY.translated(posiciones_iniciales["habitacion1"])
		
		# Descargar habitación 2 si existe
		if habitacion2 and is_instance_valid(habitacion2):
			habitacion2.queue_free()
			habitacion2 = null

func _on_area_2_body_entered(body):
	if body.name == "Avatar":
		# Cargar habitación 2 si no existe
		if !habitacion2 or !is_instance_valid(habitacion2):
			habitacion2 = _cargar_habitacion(ruta_habitacion2, "habitacion2")
			if habitacion2:
				add_child(habitacion2)
				habitacion2.global_transform = Transform3D.IDENTITY.translated(posiciones_iniciales["habitacion2"])
		
		# Descargar habitación 1 si existe
		if habitacion1 and is_instance_valid(habitacion1):
			habitacion1.queue_free()
			habitacion1 = null

func _on_area_1_body_exited(body):
	pass

func _on_area_2_body_exited(body):
	pass
