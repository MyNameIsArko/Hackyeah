extends TextureRect

@export var percentage = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ColorRect.scale = Vector2(1, percentage)
