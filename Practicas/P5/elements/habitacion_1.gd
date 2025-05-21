extends Node3D

func _ready():
	var palanca = $Palanca/StaticBody3D
	var plataforma_real = $Ascensor.get_node("Plataforma")
	palanca.connect("palanca_activada", Callable(plataforma_real, "toggle_move"))
