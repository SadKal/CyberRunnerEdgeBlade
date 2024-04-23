extends Area2D

var velocity = Vector2.RIGHT
var speed = 200.0

func _process(delta):
	position = position + speed * velocity * delta
	$AnimatedSprite2D.play()
