extends TextureButton

var ball_item
var object_present: bool = false
var rng = RandomNumberGenerator.new()
var is_launched = false

func _process(delta):
	if object_present:
		var mouse_position = get_global_mouse_position()
		ball_item.global_position = mouse_position

func _integrate_forces(state):
	if is_launched:
		is_launched = false
		ball_item.global_position = get_global_mouse_position()
		ball_item.apply_impulse(Vector2(2000, 2000))

func _on_button_down():
	object_present = true
	ball_item = load("res://objects/ui/ball/Ball3.tscn").instantiate()
	ball_item.global_position = get_global_mouse_position()
	get_tree().get_root().add_child(ball_item)

func _on_button_up():
	object_present = false
	is_launched = true
