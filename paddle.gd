extends CharacterBody2D

@export var speed: float = 250.0
var initialx: float

func _physics_process(_delta: float) -> void:
	
	if Global.isPlaying == true:
		
		velocity = Vector2.ZERO
		if Input.is_action_pressed("move_left"):
			velocity.y = speed
		if Input.is_action_pressed("move_right"):
			velocity.y = -speed
					
	self.position.x = initialx #stops paddle from being dragged away by the ball
					
	move_and_slide()
