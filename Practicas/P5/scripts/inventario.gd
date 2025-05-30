extends Panel

@onready var slots = [$Slot1, $Slot2, $Slot3]  # Ajusta los nombres según tu escena

func actualizar_inventario(inventario: Array):
	for i in range(slots.size()):
		if i < inventario.size() and is_instance_valid(inventario[i]):
			var obj = inventario[i]
			if (obj.name == "Gancho"):
				slots[i].texture = load("res://img/gancho.png")
			else:
				slots[i].texture = load("res://img/bola.png") 
		else:
			slots[i].texture = null  # Slot vacío
