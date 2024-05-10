extends Node

@export var maxBuffs = 5

var buffSpawner = preload("res://Scenes/BuffSpawner/buff_spawner.tscn")
var drone = preload("res://Scenes/Drone/drone.tscn")
var coll: CollisionShape2D
var min_spawn 
var max_spawn 

var diff_multiplier = 1

func _ready():
	coll = get_node("/root/Main/Area2D/CollisionShape2D")
	min_spawn = coll.position + coll.get_shape().get_rect().position
	max_spawn = coll.get_shape().get_rect().size + coll.position + coll.get_shape().get_rect().position

func _on_spawner_timeout():
	var rng = RandomNumberGenerator.new()
	
	if get_tree().get_nodes_in_group("buffs").size() <= maxBuffs:
		var newBuff = buffSpawner.instantiate()
		newBuff.global_position = Vector2(rng.randf_range(min_spawn.x, max_spawn.x), rng.randf_range(min_spawn.y, max_spawn.y))
		add_child(newBuff)
		var player_node = get_node("/root/Main/Player")
		newBuff.setup(player_node)
	
	var newDrone = drone.instantiate()
	newDrone.global_position = Vector2(rng.randf_range(min_spawn.x, max_spawn.x), rng.randf_range(min_spawn.y, max_spawn.y))
	newDrone.MAX_HEALTH = 100 * diff_multiplier
	add_child(newDrone)


func _on_diff_timer_timeout():
	diff_multiplier += 1
	$HUD/Difficulty.text = "Level: " + str(diff_multiplier)
