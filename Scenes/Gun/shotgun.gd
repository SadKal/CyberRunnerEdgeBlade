extends Gun
class_name Shotgun

func setup():
	super()
	self.damage = 10
	self.fire_rate = 1
	add_to_group("shotguns")
