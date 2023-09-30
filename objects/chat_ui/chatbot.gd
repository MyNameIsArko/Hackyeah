extends Control

var past_user_inputs = []
var generated_responses = []
var endpoint_url = "https://api-inference.huggingface.co/models/microsoft/DialoGPT-medium"
var headers = ["Authorization: Bearer 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"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request_completed.connect(_on_request_completed)


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	var chat_text = json['generated_text']
	$Conversation.add_text(chat_text + '\n')
	generated_responses.append(chat_text)


func _on_input_text_submitted(new_text):
	var data = JSON.stringify({"inputs": {"text": new_text, "past_user_inputs": past_user_inputs, "generated_responses": generated_responses}})
	past_user_inputs.append(new_text)
	$Input.clear()
	$HTTPRequest.request(endpoint_url, headers, HTTPClient.METHOD_POST, data)
