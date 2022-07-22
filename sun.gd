extends TextureRect


var x_max: int


func _ready():
	x_max = get_viewport().get_visible_rect().size[0]


func _process(delta):
	self.rect_position.x += cos(delta)
	self.rect_position.y += sin(delta)

	if self.rect_position.x > x_max:
		self.rect_position.x = -50
