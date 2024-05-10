extends CanvasLayer


var time := 0.0
var player

func _ready():
	player = get_node("/root/Main/Player")


func _process(delta):
	time += delta
	var minutes := time / 60
	var seconds := fmod(time, 60)
	var milliseconds := fmod(time, 1) * 100
	var time_string := "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
	$TimeElapsedLabel.text = "[center]" + time_string + "[center]"
	
	$LifeBar.value = player.health
