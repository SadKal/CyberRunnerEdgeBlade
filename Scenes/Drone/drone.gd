extends Area2D

var MAX_HEALTH 
var health

var follow 

func _ready():
	health = MAX_HEALTH

func _process(delta):	
	$HealthBar.value = (health / MAX_HEALTH) * 100
	
	if health <= 0:
		queue_free()

func _on_area_entered(area):
	if area.get_groups().has("bullets"):
		health -= area.damage
		area.queue_free()

func _on_can_follow_timeout():
	follow = true
