extends Node

@onready var dinosaur = $Dinosaur
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Timer start")

func _on_timer_timeout():
	print("ping")
	dinosaur.be_hungry()
	dinosaur.status()
