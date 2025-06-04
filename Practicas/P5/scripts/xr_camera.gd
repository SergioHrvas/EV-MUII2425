extends Node3D

var xr_interace: XRInterface

func _ready() -> void:
	var mock_interface = XRServer.find_interface("MockHMD")
	if mock_interface and mock_interface.initialize():
		get_viewport().use_xr = true
	else:
		print("MOCKHMD no inicializado")
	xr_interace = XRServer.find_interface("OpenXR")
	if xr_interace and xr_interace.is_initialized():
		print("OpenXR initialized sucessfully")
		
		#Desactivamos v-sync
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		#Cambiamos nuestro viewport principal a la salida del HMD
		get_viewport().use_xr = true
	else:
		print("OPENXR No inicializado")
