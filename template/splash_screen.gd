extends Node2D


@onready var sprite_2d: Sprite2D = $Sprite2D
@export var view_time: int = 5
var screenSize: Vector2 = Vector2()


func _ready() -> void:
	Debug.print_type_of(screenSize, "screenSize")
	screenSize = get_viewport_rect().size
	sprite_2d.position = screenSize / 2
	exit_splash()


func exit_splash() -> void:
	await get_tree().create_timer(view_time).timeout
	SceneManager.change_scene(SceneManager.TITLE_SCREEN, "fade_to_black", 0.25)
