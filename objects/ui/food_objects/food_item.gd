extends Area2D

var player = null

@export var food_amount = 30
@export var fun_amount = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("click") and player != null:
		player.feed(food_amount)
		player.have_fun(fun_amount)
		call_deferred("queue_free")

func _on_body_entered(body):
	if body.name == 'Dinosaur':
		player = body



func _on_body_exited(body):
	if body.name == 'Dinosaur':
		player = null
