extends State
class_name drone_idle

@export var drone: Area2D
@export var SPEED := 100

var target 
var velocity : Vector2

func Enter():
	target = get_node("/root/Main/Player")

func Update(delta: float):
	if drone:
		var velocity = drone.global_position.direction_to(target.global_position)
		drone.position += velocity * SPEED * delta
