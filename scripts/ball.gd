extends CharacterBody2D
class_name Ball

var speed: int = 250
var startingMovement: Vector2 = Vector2.ZERO
var startArray: Array = [Vector2(-1,-1), Vector2(-1,1), Vector2(1,1), Vector2(1,-1)]
var viewport: Vector2
@onready var paddle: CharacterBody2D = $"../../Paddle"



func _ready() -> void:
	if Global.firstBall == true:
		startingMovement = startArray[randi_range(0,3)]
		Global.firstBall = false
	else: 
		startingMovement = self.global_position.direction_to(paddle.global_position)
		
	velocity = speed * startingMovement
	
func _physics_process(delta: float) -> void:
	var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info: # We only want to bounce if the ball actually collided.
		velocity *= 1.0005
		SignalBus.shake.emit()
		velocity = velocity.bounce(collision_info.get_normal())
		var collider: Brick = collision_info.get_collider() as Brick
		if collider is Brick:
			collider.hit(1)
			if !collider.hp == 0:
				SignalBus.grant_score.emit(10)
			else: 
				SignalBus.grant_score.emit(25)


		
	
