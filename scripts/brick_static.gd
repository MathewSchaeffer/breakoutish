extends StaticBody2D
class_name Brick

@export var hp: int = 3

func _ready() -> void:
	check_status() #allocate correct colours to bricks depending on number of HP
	
func hit(damage: int) -> void:
	hp -= damage
	check_status()

func check_status() -> void:
	if hp == 3:
		self.modulate = Color(Color.GREEN)
	elif hp == 2:
		self.modulate = Color(Color.YELLOW)
	elif hp == 1:
		self.modulate = Color(Color.RED)
	elif hp < 1:
		queue_free()
	
