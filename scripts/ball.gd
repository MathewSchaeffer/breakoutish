extends CharacterBody2D

var speed: int = 250
var startingMovement: Vector2 = Vector2.ZERO
var startArray: Array = [Vector2(-1,-1), Vector2(-1,1), Vector2(1,1), Vector2(1,-1)]
var viewport: Vector2
#@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
#var audioPitchScale = 1


func _ready() -> void:
	
	#viewport = get_viewport_rect().size
	#self.position.x = viewport.x / 2
	#self.position.y = viewport.y / 2
	startingMovement = startArray[randi_range(0,3)]
	velocity = speed * startingMovement
	
func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info: # We only want to bounce if the ball actually collided.
		velocity *= 1.005
		print("BOING")
		velocity = velocity.bounce(collision_info.get_normal())
		var collider = collision_info.get_collider()
		if collider.is_in_group("bricks"):
			collider.queue_free()
		#audio_stream_player.play()
		#audioPitchScale *= 1.05
		#audio_stream_player.pitch_scale = audioPitchScale
		#SignalBus.shake.emit()
		

		
	
