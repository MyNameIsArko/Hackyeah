extends Node

@onready var dinosaur = $Dinosaur
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Timer start")
	
func _process(delta):
	if Input.is_action_just_pressed("feed"):
		dinosaur.feed(10)
		print("Thank you!")

func _on_timer_timeout():
	print("ping")
	dinosaur.be_hungry()
	dinosaur.food_status()
