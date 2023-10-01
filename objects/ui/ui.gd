extends Control

enum GameState {
	IDLE,
	FEEDING,
	PLAYING,
	MINIGAME
}

var state = GameState.IDLE
var energy_level = 100

signal game_state(arg1)

var past_user_inputs = []
var generated_responses = []
var endpoint_url = "https://api-inference.huggingface.co/models/microsoft/DialoGPT-large"
var headers = ["Authorization: Bearer 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"]
var is_initial_prompt = true

var last_prompt = ""

func ask_chatbot(text):
	if energy_level <= 0:
		return
	var data = JSON.stringify({
		"inputs": {"text": text, "past_user_inputs": past_user_inputs, "generated_responses": generated_responses},
		"options": {"wait_for_model": true}
		})
	last_prompt = text
	$Input.editable = false
	$HTTPRequest.request(endpoint_url, headers, HTTPClient.METHOD_POST, data)

# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request_completed.connect(_on_request_completed)
	ask_chatbot("I want you to act as a dinosaur in the childs game. They can take care of you. You need to get into this role very seriously. You can only answer very simple")
	set_process(true)
	$HBoxContainer2.visible = true
	
func _process(delta):
	emit_signal("game_state", state)
	

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	var chat_text = json['generated_text']
	generated_responses.append(chat_text)
	$Input.editable = true
	if is_initial_prompt:
		is_initial_prompt = false		
		return
	$Conversation.text = chat_text
	$Conversation/TalkingAudio.play()


func _on_input_text_submitted(new_text):
	ask_chatbot(new_text)
	past_user_inputs.append(new_text)
	$Input.clear()
	
	
func _on_game_dino_params(arg1):
	$HBoxContainer/Food.percentage = arg1['food_param'] / 100.0
	$HBoxContainer/Sleep.percentage = arg1['sleep_param'] / 100.0
	$HBoxContainer/Enjoy.percentage = arg1['fun_param'] / 100.0
	energy_level = arg1['sleep_param']


func _on_texture_button_button_down():
	state = GameState.FEEDING
	$AnimationPlayer.play("food_slide_in")
	$HBoxContainer2/FoodButton/ButtonAudio.play()


func _on_texture_button_3_button_down():
	state = GameState.PLAYING
	$AnimationPlayer.play("play_slide_in")
	$HBoxContainer2/PlayButton/ButtonAudio.play()


func _on_texture_button_2_button_down():
	state = GameState.MINIGAME
	$AnimationPlayer.play("minigame_slide_in")
	$HBoxContainer2/MinigameButton/ButtonAudio.play()


func _on_cancel_button_button_down():
	match state:
		GameState.MINIGAME:
			$AnimationPlayer.play("minigame_slide_in", -1, -1, true)
		GameState.PLAYING:
			$AnimationPlayer.play("play_slide_in", -1, -1, true)
		GameState.FEEDING:
			$AnimationPlayer.play("food_slide_in", -1, -1, true)
	state = GameState.IDLE
