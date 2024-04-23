extends CharacterBody2D

signal shoot(bullet, direction, location)

@export var speed = 100

var gun_number = 0
var gun = preload("res://gun.tscn")
var Bullet = preload("res://bullet.tscn")
var gunArray = []

var radius_speed = 0
	
func get_input(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	
	if Input.is_action_just_pressed("right_click") and gun_number < 6:
		add_child(gun.instantiate())
		gun_number += 1

	gunArray = get_tree().get_nodes_in_group("guns")	
	update_gun_position(delta, gunArray)
	
	if Input.is_action_pressed("click"):
		shoot_guns(gunArray)
	
	#$Label.text = str(input_direction)
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

func _physics_process(delta):
	get_input(delta)
	move_and_slide()

func update_gun_position(delta, guns):
	
	for index in guns.size():
		var angle = 2 * PI * index / gunArray.size() + radius_speed * delta
		var currentGun = gunArray[index]
		currentGun.position = Vector2(
			sin(angle) * currentGun.radius,
			cos(angle) * currentGun.radius 
		) 
	radius_speed += 1.5
	
func shoot_guns(guns):
	for currentGun in guns:
		currentGun.shooting = true
		var animatedSprite = currentGun.get_node("AnimatedSprite2D")
		animatedSprite.play("shooting")
		if not currentGun.is_connected("bullet_ready", _on_bullet_ready):
			currentGun.connect("bullet_ready", _on_bullet_ready)

func _on_bullet_ready(bulletRotation, bulletPosition):
		shoot.emit(Bullet, bulletRotation, bulletPosition)
