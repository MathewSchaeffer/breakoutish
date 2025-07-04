extends Polygon2D
class_name BallSpawn
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_anim() -> void:
	animation_player.play("zoom_spawn")
