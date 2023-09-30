extends CharacterBody2D

#stats:

#food_param - is the dino hungry? How much?

var food_param: float = 100.0
var sleep_param: float = 100.0

func feed(food_index) -> void:
	
	food_param += food_index
	if food_param >= 100.0:
		food_param = 100.0
	
func be_hungry(hunger_index = 1.0) -> void:
	
	if food_param > 0:
		food_param -= hunger_index
	
	if food_param >= 100:
		food_param = 100
	
func food_status() -> int:
	
	print("Food_param: ", food_param)
	
	if food_param == 0:
		print("I'm starving!")
		return 2
	elif food_param == 100.0:
		print("I'm full!")
		return 1
	else:
		return 0
		
func regenerate_sleep() -> void:
	pass

func sleep_status() -> int:
	return 0
