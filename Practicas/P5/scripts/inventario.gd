extends Panel

@onready var slots = [$Slot1, $Slot2, $Slot3]
@onready var images = [$Slot1/Image1, $Slot2/Image2, $Slot3/Image3]

# Funcion para actualizar la interfaz del inventario
func actualizar_inventario(inventario: Array):
	# Por cada slot
	for i in range(images.size()):
		# Si el inventario no esta lleno o no es valida la instancia
		if i < inventario.size() and is_instance_valid(inventario[i]):
			var obj = inventario[i]
			
			# Asignamos las texturas
			if (obj.name == "Gancho"):
				images[i].texture = load("res://img/gancho.png")
			else:
				images[i].texture = load("res://img/bola.png")
		else:
			images[i].texture = null  # Slot vacío
			slots[i].color = "#3e3e3e"
			
# Funcion para marcar el inventario
func marcar(indice: int):
	# Por cada slot
	for i in range(slots.size()):
		# Si es el indice, lo marcamos como seleccionado
		if(indice==i):
			slots[i].color = "#8f8f8f"
		# Si no, lo desmarcamos
		else:
			slots[i].color = "#3e3e3e"

	
