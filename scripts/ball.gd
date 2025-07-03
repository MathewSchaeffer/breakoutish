extends CharacterBody2D

var speed: int = 250
var startingMovement: Vector2 = Vector2.ZERO
var startArray: Array = [Vector2(-1,-1), Vector2(-1,1), Vector2(1,1), Vector2(1,-1)]
var viewport: Vector2


func _ready() -> void:
	startingMovement = startArray[randi_range(0,3)]
	velocity = speed * startingMovement
	
func _physics_process(delta: float) -> void:
	var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info: # We only want to bounce if the ball actually collided.
		#velocity *= 1.005
		SignalBus.shake.emit()
		velocity = velocity.bounce(collision_info.get_normal())
		var collider: Brick = collision_info.get_collider() as Brick
		if collider is Brick:
			collider.hit(1)
		

		
	
