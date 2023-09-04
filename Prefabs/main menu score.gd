extends Label

func _process(delta):
	self.text = "Score: " + str(Global.coins)
