extends CharacterBody2D

@export var speed: float = 300.0
var initialPosition: Vector2

func _ready() -> void:
	
	center_paddle()
	initialPosition = self.position
	
func center_paddle() -> void:
	var screenSize: Vector2 = get_viewport_rect().size
	self.position.x = screenSize.x / 2
	print(self.position)
	print(screenSize)

func _physics_process(_delta: float) -> void:
	
	if Global.isPlaying == true:
		velocity = Vector2.ZERO
		if Input.is_action_pressed("move_left"):
			velocity.x = -speed
		if Input.is_action_pressed("move_right"):
			velocity.x = speed
					
	self.position.y = initialPosition.y #stops paddle from being dragged away by the ball
	move_and_slide()
