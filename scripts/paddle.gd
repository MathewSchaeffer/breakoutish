extends CharacterBody2D

@export var speed: float = 500.0
@export var deltaTest: bool = false
var initialPosition: Vector2
var mobile_direction: int

func _ready() -> void:
	center_paddle()
	initialPosition = self.position
	SignalBus.mobile_touch_left.connect(mobile_movement_left)
	SignalBus.mobile_touch_right.connect(mobile_movement_right)
	
func mobile_movement_left() -> void:
	mobile_direction = -1
	
func mobile_movement_right() -> void:
	mobile_direction = 1
	

	
	
func center_paddle() -> void:
	var screenSize: Vector2 = get_viewport_rect().size
	self.position.x = screenSize.x / 2


func _physics_process(_delta: float) -> void:
	input_and_movement()
	



func input_and_movement() -> void:
	if Global.isPlaying == true:
		#velocity = Vector2.ZERO
		var direction: int = 0
		mobile_direction = 0
		if Input.is_action_pressed("move_left") or mobile_direction == -1:
			#velocity.x = -speed 
			direction = -1
		if Input.is_action_pressed("move_right") or mobile_direction == 1:
			#velocity.x = speed 
			direction = 1
			
		velocity.x = direction * speed
					
	self.position.y = initialPosition.y #stops paddle from being dragged away by the ball
	move_and_slide()
