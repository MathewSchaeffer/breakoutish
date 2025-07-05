extends Node2D

var screenSize: Vector2
var playerScore: int = 0
@onready var score_label: Label = $CanvasLayer/UI/Score
@onready var animation_player: AnimationPlayer = $CanvasLayer/UI/Score/AnimationPlayer
@onready var balls: Node = $GameField/Balls
@onready var lives_icon_container: Node = $CanvasLayer/Lives/LivesIconContainer
var livesIcons: Array 




const BALL_SPAWN: PackedScene = preload("res://scenes/ball_spawn.tscn")
const BALL: PackedScene = preload("res://scenes/ball.tscn")

func _ready() -> void:
	screenSize = get_viewport_rect().size
	SignalBus.spawn_new_ball.connect(spawn_ball)
	SignalBus.grant_score.connect(increase_score)
	SignalBus.lose_life.connect(lives_check)
	livesIcons = lives_icon_container.get_children()
	
func spawn_ball() -> void:
	if Global.lives <= 0:
		return
	else:
		var newBallSpawn: BallSpawn = BALL_SPAWN.instantiate()
		screenSize = get_viewport_rect().size
		newBallSpawn.position = screenSize / 2
		balls.add_child(newBallSpawn)
		newBallSpawn.play_anim()
		await newBallSpawn.animation_player.animation_finished
		newBallSpawn.queue_free()
		var newBall: Ball = BALL.instantiate()
		newBall.position = screenSize / 2
		balls.add_child(newBall)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		SceneManager.change_scene(SceneManager.LEVEL_2, "swipe_from_left", 1)
	
func increase_score(score: int) -> void:
	playerScore += score
	score_label.text = str(playerScore)
	#animation_player.play("score_up")
	


func _on_ball_grant_score(val: int) -> void:
	increase_score(val) # Replace with function body.
	
func lives_check() -> void:
	print("LIVES CHECK IN PROGRESS")

	if Global.lives >= 0:
		#livesIcons[-1].queue_free()
		#livesIcons.remove_at(-1)
		var selectedIcon: Node = livesIcons.pop_back()
		selectedIcon.queue_free()
		print(livesIcons)
		
	else:
		var selectedIcon: Node = livesIcons.pop_back()
		selectedIcon.queue_free()
		print(livesIcons)
		print("GAME OVER")
		SignalBus.game_over.emit()
