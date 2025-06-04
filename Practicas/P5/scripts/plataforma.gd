extends StaticBody3D

# Definimos las variables
var bola_colocada := false
var luz: OmniLight3D = null

func _ready():
	# Conectamos las señales
	$DetectorBola.body_entered.connect(_on_body_entered)
	$DetectorBola.body_exited.connect(_on_body_exited)
	
	luz = get_parent().get_node("OmniLight3D")

# Funcion para cuando la bola entra
func _on_body_entered(body):
	# Si entra la bola y no estaba colocada, la detecta y cambia la luz a naranja
	if body.is_in_group("cogible") and not bola_colocada and body.name.begins_with("Bola"):
		bola_colocada = true
		if(luz != null):
			luz.light_color = "#e58218"

# Funcion para cuando la bola sale
func _on_body_exited(body):
	# Si sale la bola y estaba colocada, la detecta y cambia la luz a verde
	if body.is_in_group("cogible") and bola_colocada and body.name.begins_with("Bola"):
		bola_colocada = false
		if(luz != null):
			luz.light_color = "#00c014"
