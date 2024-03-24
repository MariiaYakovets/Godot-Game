extends Path2D

var move = 0.0

func _ready() -> void:
	$PathFollow2D/AnimationPlayer.play("moving")

func _process(delta: float) -> void:
	move += delta
	$PathFollow2D.progress = move * 100
