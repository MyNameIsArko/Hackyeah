extends Node

@onready var dinosaur = $Dinosaur
@onready var timer = $Timer

signal dino_params

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Timer start")
	set_process(true)

	
func _process(delta):
	if Input.is_action_just_pressed("feed"):
		dinosaur.feed(10)
		print("Thank you!")
		dinosaur.food_status()
	emit_signal("dino_params", dinosaur.get_signals())

func _on_timer_timeout():
	dinosaur.be_hungry()
	dinosaur.food_status()
	dinosaur.be_tired()
	dinosaur.be_bored()

func _on_dino_params(arg1):
	pass
