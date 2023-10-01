extends TextureButton



var food_item
var object_present: bool = false


func _process(delta):
	if object_present:
		var mouse_position = get_global_mouse_position()
		food_item.global_position = mouse_position

func _on_button_down():
	object_present = true
	food_item = load("res://objects/ui/food_objects/food_item_right.tscn").instantiate()
	add_child(food_item)

func _on_button_up():
	object_present = false
	food_item.queue_free()
