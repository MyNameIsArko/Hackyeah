extends TextureButton

var ball_item
var object_present: bool = false
var rng = RandomNumberGenerator.new()

func _process(delta):
	if object_present:
		var mouse_position = get_global_mouse_position()
		ball_item.global_position = mouse_position

func _on_button_down():
	object_present = true
	ball_item = load("res://objects/ui/ball/Ball2.tscn").instantiate()
	ball_item.global_position = get_global_mouse_position()
	get_tree().get_root().add_child(ball_item)

func _on_button_up():
	object_present = false
	ball_item.global_position = get_global_mouse_position()
	var x = rng.randf_range(0, 1.0)
	var y = rng.randf_range(0, 1.0)
	ball_item.apply_impulse(Vector2(x * 5000, y * 5000))
