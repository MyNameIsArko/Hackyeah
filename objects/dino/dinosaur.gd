extends CharacterBody2D

var is_mouse_tracked = false

var food_param: float = 100.0
var sleep_param: float = 100.0
var fun_param: float = 100.0

const SLEEP_HOURS_RECOVERY = 2

func feed(food_index) -> void:
	
	food_param += food_index
	if food_param >= 100.0:
		food_param = 100.0
		
	$EatAudio.play()
	
func be_hungry(hunger_index = 1.0) -> void:
	
	if food_param > 0:
		food_param -= hunger_index
	
	if food_param >= 100:
		food_param = 100

func be_tired(sleep_index = 1.0) -> void:
	
	if sleep_param > 0:
		sleep_param -= sleep_index
		
func be_bored(boring_index = 1.0) -> void:
	
	if sleep_param > 0:
		fun_param -= boring_index
	else:
		$AnimatedSprite2D.play("sleep")
		
func have_fun(fun_index = 1.0) -> void:
	
	fun_param += fun_index
	if fun_param >= 100.0:
		fun_param = 100.0
	
	
func food_status() -> int:
	
	print(food_param)
	
	if food_param == 0:
		#print("I'm starving!")
		return 2
	elif food_param == 100.0:
		#print("I'm full!")
		return 1
	else:
		return 0


func get_signals() -> Dictionary:
	
	var params_dict = {
		"food_param" = food_param,
		"sleep_param" = sleep_param,
		"fun_param" = fun_param
		}
	
	return params_dict
	
func _process(_delta):
	if sleep_param <= 0:
		return
	if is_mouse_tracked and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$AnimatedSprite2D.play("pat")
		if not $PatAudio.playing:
			$PatAudio.play()
	else:
		$AnimatedSprite2D.play("idle")
		$PatAudio.stop()


func _on_mouse_entered():
	is_mouse_tracked = true


func _on_mouse_exited():
	is_mouse_tracked = false
