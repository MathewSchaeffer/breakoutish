extends Node

func print_type_of(reference: Variant, debugText: String) -> void:
	print(debugText + "- is type of -" + str(typeof(reference)))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cap frame 30"):
		Engine.max_fps = 15
	if event.is_action_pressed("cap frame 60"):
		Engine.max_fps = 60
