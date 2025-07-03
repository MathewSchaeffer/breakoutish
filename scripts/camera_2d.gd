extends Camera2D

var screensize: Vector2
@export var randomStrength: float = 5.0
@export var shakeFade: float = 3.0

var rng: Object = RandomNumberGenerator.new()

var shakeStrength: float = 0.0

func apply_shake() -> void:
	if !Global.shakeEnabled:
		return
	else:
		shakeStrength = randomStrength

func _ready() -> void:
	screensize = get_viewport_rect().size
	self.position = screensize / 2
	SignalBus.shake.connect(apply_shake)
	Debug.print_type_of(rng, "rng = ")
	
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("debug_one"):
		#apply_shake()
	
	if shakeStrength > 0:
		shakeStrength = lerpf(shakeStrength, 0, shakeFade * delta)	
		
	offset = randomOffset()
	
	
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeStrength, shakeStrength), rng.randf_range(-shakeStrength, shakeStrength))
