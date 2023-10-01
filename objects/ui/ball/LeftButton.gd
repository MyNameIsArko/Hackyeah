extends TextureButton



var ball_item
var object_present: bool = false


func _process(delta):
	if object_present:
		var mouse_position = get_global_mouse_position()
		ball_item.global_position = mouse_position

func _on_button_down():
	object_present = true
	ball_item = load("res://objects/ui/ball/node_2d.tscn").instantiate()
	add_child(ball_item)

func _on_button_up():
	object_present = false
	ball_item.queue_free()
