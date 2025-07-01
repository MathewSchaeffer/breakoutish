extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
var screenSize: Vector2

func _ready() -> void:
	screenSize = get_viewport_rect().size
	camera_2d.position = screenSize / 2

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		SceneManager.change_scene(SceneManager.LEVEL_2, "swipe_from_left", 1)
	
