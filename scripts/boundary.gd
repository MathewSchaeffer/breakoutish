extends Node2D




func _on_killbox_body_entered(body: Node2D) -> void:
	if body is Ball:
		SignalBus.spawn_new_ball.emit() # Replace with function body.
