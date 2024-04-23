extends Node2D

var d = 0.0
var speed = 1.0
var radius = 30

var shooting = false
var player

signal bullet_ready(rotation, position)

func _ready():
	player = get_parent()
	add_to_group("guns")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	d += delta
	
	if (get_global_mouse_position().x - global_position.x) > 0:
		scale =  Vector2(.5, .5)
	else:
		scale = Vector2(.5, -.5)
		
	if shooting == false: 
		$AnimatedSprite2D.play("charging")
		
	look_at(get_global_mouse_position())

func _on_animated_sprite_2d_animation_finished():
	shooting = false
	bullet_ready.emit(global_rotation, global_position)
