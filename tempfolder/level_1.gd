extends Node2D

var screenSize: Vector2
var playerScore: int = 0
@onready var score_label: Label = $CanvasLayer/UI/Score
@onready var animation_player: AnimationPlayer = $CanvasLayer/UI/Score/AnimationPlayer


func _ready() -> void:
	screenSize = get_viewport_rect().size
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		SceneManager.change_scene(SceneManager.LEVEL_2, "swipe_from_left", 1)
	
func increase_score(score) -> void:
	playerScore += score
	score_label.text = str(playerScore)
	animation_player.play("score_up")
	


func _on_ball_grant_score(val) -> void:
	increase_score(val) # Replace with function body.
