extends Control

enum GameState {
	IDLE,
	FEEDING,
	PLAYING,
	MINIGAME
}

var state = GameState.IDLE

var past_user_inputs = []
var generated_responses = []
var endpoint_url = "https://api-inference.huggingface.co/models/microsoft/DialoGPT-large"
var headers = ["Authorization: Bearer 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"]
var is_initial_prompt = true

func ask_chatbot(text):
	var data = JSON.stringify({"inputs": {"text": text, "past_user_inputs": past_user_inputs, "generated_responses": generated_responses}})
	$HTTPRequest.request(endpoint_url, headers, HTTPClient.METHOD_POST, data)

# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request_completed.connect(_on_request_completed)
	ask_chatbot("I want you to act as a dinosaur in the childs game. They can take care of you. You need to get into this role very seriously. You can only answer very simple")
	set_process(true)
	$HBoxContainer2.visible = true


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	var chat_text = json['generated_text']
	generated_responses.append(chat_text)
	if is_initial_prompt:
		is_initial_prompt = false
		$Input.editable = true
		return
	$Conversation.text = chat_text


func _on_input_text_submitted(new_text):
	ask_chatbot(new_text)
	past_user_inputs.append(new_text)
	$Input.clear()
	
	
func _on_game_dino_params(arg1):
	$HBoxContainer/Stat.percentage = arg1['food_param'] / 100.0
	$HBoxContainer/Stat2.percentage = arg1['sleep_param'] / 100.0
	$HBoxContainer/Stat3.percentage = arg1['fun_param'] / 100.0


func _on_texture_button_button_down():
	state = GameState.FEEDING
	$AnimationPlayer.play("food_slide_in")


func _on_texture_button_3_button_down():
	state = GameState.PLAYING
	$AnimationPlayer.play("play_slide_in")


func _on_texture_button_2_button_down():
	state = GameState.MINIGAME
	$AnimationPlayer.play("minigame_slide_in")


func _on_cancel_button_button_down():
	match state:
		GameState.MINIGAME:
			$AnimationPlayer.play("minigame_slide_in", -1, -1, true)
		GameState.PLAYING:
			$AnimationPlayer.play("play_slide_in", -1, -1, true)
		GameState.FEEDING:
			$AnimationPlayer.play("food_slide_in", -1, -1, true)
