extends CharacterBody2D

signal shoot(bullet, direction, location)

@export var speed = 100
@export var MAX_HEALTH = 100
var health

var gun_number = 0
var shotgun = preload("res://Scenes/Gun/shotgun.tscn")
var pistol = preload("res://Scenes/Gun/pistol.tscn")
var guns = []
var radius_speed = 0
	
func _ready():	
	health = MAX_HEALTH
	var coll = get_node("/root/Main/Area2D/CollisionShape2D")
	position = (coll.get_shape().get_rect().size + coll.position + coll.get_shape().get_rect().position) / 2
	add_gun()
	add_to_group("player")
	
func _physics_process(delta):
	get_movement_input(delta)
	get_shooting_input(delta)
	
func get_shooting_input(delta):
	if Input.is_action_just_pressed("add_pistol"):
		add_gun("pistol")
	if Input.is_action_just_pressed("add_shotgun"):
		add_gun("shotgun")
	guns = get_tree().get_nodes_in_group("guns")
	update_gun_position(delta)
	
	if Input.is_action_pressed("click"):
		get_tree().call_group("guns", "shoot")
	
		
func get_movement_input(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	#$Label.text = str(position)
	if velocity.is_zero_approx():
		$AnimatedSprite2D.animation = "idle"
	else:
		match input_direction:
			Vector2(1,0):
				$AnimatedSprite2D.animation = "walk-east"
			Vector2(-1,0):
				$AnimatedSprite2D.animation = "walk-west"
			Vector2(0,1):
				$AnimatedSprite2D.animation = "walk"
		
	$AnimatedSprite2D.play()
	
	var coll = get_node("/root/Main/Area2D/CollisionShape2D")
	var min_position = coll.position + coll.get_shape().get_rect().position
	var max_position = coll.get_shape().get_rect().size + coll.position + coll.get_shape().get_rect().position
	position += velocity * delta
	position.x = clamp(position.x, min_position.x, max_position.x)
	position.y = clamp(position.y, min_position.y, max_position.y)

func update_gun_position(delta):
	var shotguns = get_tree().get_nodes_in_group("shotguns")
	var pistols = get_tree().get_nodes_in_group("pistols")		
	orbit(shotguns, delta, true)
	orbit(pistols, delta, false)
	radius_speed += 1.5
	
func orbit(guns_array, delta, direction):
	for index in guns_array.size():
		var dir = radius_speed if direction else -radius_speed
		var angle = 2 * PI * index / guns_array.size() + dir * delta
		var currentGun = guns_array[index]
		currentGun.position = Vector2(
			sin(angle) * currentGun.radius,
			cos(angle) * currentGun.radius 
		) 
		
func add_gun(gun_type = "pistol"):
	if gun_number < 10000:
		var new_gun
		match gun_type:
			"pistol":
				new_gun = pistol.instantiate()
			"shotgun":
				new_gun = shotgun.instantiate()
		new_gun.setup()
		add_child(new_gun)
		gun_number += 1

