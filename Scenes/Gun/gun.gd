class_name Gun
extends Node2D

var Bullet = preload("res://Scenes/Bullet/bullet.tscn")

var shooting = false
var player
var damage: float
var fire_rate: float
var radius: float = 30

func _ready():
	player = get_parent()
	
func _process(_delta):
	if (get_global_mouse_position().x - global_position.x) > 0:
		scale =  Vector2(.5, .5)
	else:
		scale = Vector2(.5, -.5)
		
	if shooting == false: 
		$AnimatedSprite2D.play("charging")
	look_at(get_global_mouse_position())

func setup():
	add_to_group("guns")
	
func shoot():
	shooting = true
	$AnimatedSprite2D.play("shooting")

func _on_animated_sprite_2d_animation_finished():
	shooting = false
	var spawned_bullet = Bullet.instantiate()
	spawned_bullet.rotation = global_rotation
	spawned_bullet.position = global_position
	spawned_bullet.velocity = spawned_bullet.velocity.rotated(global_rotation)
	spawned_bullet.damage = self.damage
	get_node("/root/Main").add_child(spawned_bullet)

