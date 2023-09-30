extends Node

func _ready():
	if Engine.has_singleton("AndroidInterface"):
		var android_interface = Engine.get_singleton("AndroidInterface")
		var current_time = android_interface.loadTime()
		
		if current_time != "":
			print("Wczytano czas: " + current_time)
		else:
			print("Nie udało się wczytać czasu.")
	else:
		print("Brak interfejsu Androida.")
