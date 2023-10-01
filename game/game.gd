extends Node

var time_file = "user://time.save"

@onready var dinosaur = $Dinosaur
@onready var timer = $Timer

signal dino_params

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Timer start")
	set_process(true)
	
	if not FileAccess.file_exists(time_file):
		return
		
	var file = FileAccess.open(time_file, FileAccess.READ)
	var last_time = file.get_var()
	var energy = file.get_var()
	file.close()
	
	var current_time = Time.get_datetime_dict_from_system()
	var difference_time = {}
	
	for key in last_time.keys():
		if key == 'dst':
			continue
		difference_time[key] = current_time[key] - last_time[key]
	
	var hours_difference = 0.0
	for key in difference_time.keys():
		var value = float(difference_time[key])
		match key:
			"second":
				value /= 3600
			"minute":
				value /= 60
			"day":
				value *= 24
			"month":
				value *= 720
			"year":
				value *= 262800
		
		hours_difference += value
		
	
	dinosaur.sleep_param = energy + min(0, max(100, hours_difference - dinosaur.SLEEP_HOURS_RECOVERY))

	
func _process(delta):
	if Input.is_action_just_pressed("feed"):
		dinosaur.feed(10)
		print("Thank you!")
		dinosaur.food_status()

func _on_timer_timeout():
	dinosaur.be_hungry()
	dinosaur.food_status()
	dinosaur.be_tired()
	dinosaur.be_bored()
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST || what == NOTIFICATION_WM_GO_BACK_REQUEST:
		var file = FileAccess.open(time_file, FileAccess.WRITE)
		file.store_var(Time.get_datetime_dict_from_system())
		file.store_var(dinosaur.sleep_param)
		file.close()
