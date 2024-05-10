extends Node2D

var player 

func setup(player_node):
	$SpawnerSprite.play()
	player = player_node
	add_to_group("buffs")

func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		player.add_gun()
		var tween : Tween = create_tween().set_parallel(true)
		tween.tween_property(self, "position:y", position.y - 10.0, .3)
		tween.tween_property(self, "modulate", Color(255, 255, 255, 0), .3)
		tween.chain().tween_callback(queue_free)
