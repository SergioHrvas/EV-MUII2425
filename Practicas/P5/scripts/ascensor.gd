extends AnimatableBody3D

# Definimos las variables
@export var delay_before_descend := 5.0
var up = false
var player_on_elevator = false
var time_on_elevator = 0.0
var esperando_subida := false

func _ready():
	# Conectamos las señales
	var area = $Area3D
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)


func _process(delta):
	# Si el jugador esta sobre el ascensor y este esta arriba del pasillo
	if player_on_elevator and up:
		# Aumentamos el tiempo
		time_on_elevator += delta
		
		# Si ha llegado al umbral del tiempo
		if time_on_elevator >= delay_before_descend:
			toggle_move()  # baja
			time_on_elevator = 0.0  # resetea el tiempo


func toggle_move():
	var anim_node = get_parent().get_node("AnimationPlayer")
	# Si esta arriba, baja
	if up:
		anim_node.play("bajada")
		up = false
	# Si esta abajo, sube
	else:
		anim_node.play("subida")
		esperando_subida = true
		
		# Conectamos la señal de fin de animacion
		if not anim_node.is_connected("animation_finished", Callable(self, "_on_animacion_finalizada")):
			anim_node.connect("animation_finished", Callable(self, "_on_animacion_finalizada"))

# Fin de animacion
func _on_animacion_finalizada(nombre_anim):
	# Si acaba la animacion subida y esta esperando la subida
	if nombre_anim == "subida" and esperando_subida:
		up = true
		esperando_subida = false
		
		# Desconectar para evitar llamadas innecesarias
		var anim_node = get_parent().get_node("AnimationPlayer")
		if anim_node.is_connected("animation_finished", Callable(self, "_on_animacion_finalizada")):
			anim_node.disconnect("animation_finished", Callable(self, "_on_animacion_finalizada"))

# Si entra el avatar
func _on_body_entered(body):
	if body.name == "Avatar": 
		player_on_elevator = true
		time_on_elevator = 0.0  # reinicia el contador al entrar

# Si sale el avatar
func _on_body_exited(body):
	if body.name == "Avatar":
		player_on_elevator = false
		time_on_elevator = 0.0  # reinicia el contador al salir
