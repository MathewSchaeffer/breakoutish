extends StaticBody2D
class_name Brick

@export var hp: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_for_death()
	
func hit(damage: int) -> void:
	print("hobby! I've been hit!")
	hp -= damage
	print(hp)
	check_for_death()

func check_for_death() -> void:
	if hp == 3:
		self.modulate = Color(Color.GREEN)
	elif hp == 2:
		self.modulate = Color(Color.YELLOW)
	elif hp == 1:
		self.modulate = Color(Color.RED)
	elif hp < 1:
		queue_free()
	
