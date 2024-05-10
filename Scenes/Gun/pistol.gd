extends Gun
class_name Pistol

func setup():
	super()
	self.damage = 5
	self.fire_rate = 2
	self.radius = 45
	add_to_group("pistols")
