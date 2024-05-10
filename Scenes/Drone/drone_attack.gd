extends Node


var target
@export var DAMAGE := 50

func Enter():
	target = get_node("/root/Main/Player")

func _process(delta):
	pass
