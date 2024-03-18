extends Node2D

var move = 0.0

func _ready() -> void:
	$Path2D/PathFollow2D/AnimationPlayer.play("moving")

func _process(delta: float) -> void:
	move += delta
	$Path2D/PathFollow2D.progress = move * 100
