extends Node2D

var _points := []
var _sticks := []
var _friction := 0.999
var _elements := 10

onready var hook: Node2D = get_node("/root/Main/Hook")

func distance(p0: Dictionary, p1: Dictionary) -> float:
	var dx = p1.x - p0.x
	var dy = p1.y - p0.y
	return sqrt(dx * dx + dy * dy)


func _init() -> void:
	print("Hook: ", hook)

	for _i in range(_elements):
		var x = rand_range(0, 300)
		var y = rand_range(0, 300)
		var oldx = x + rand_range(-10, 10)
		var oldy = y + rand_range(-10, 10)
		self._points.append({x = x, y = y, oldx = oldx, oldy = oldy, pinned = false})

	self._points[0].x = 0
	self._points[0].y = 0
	self._points[0].oldx = 0
	self._points[0].olyy = 0
	self._points[0].pinned = true

	self._points[_elements-1].pinned = true

	for i in range(1, len(self._points)):
		self._sticks.append(
			{
				p0 = self._points[i - 1],
				p1 = self._points[i],
			}
		)

	for s in self._sticks:
		s.length = distance(s.p0, s.p1)


func _process(_delta) -> void:


	self._update_points()
	for _i in range(0, 3):
		self._update_sticks()

	# Calls _draw
	self.update()

	self._points[_elements-1].x = hook.position.x
	self._points[_elements-1].y = hook.position.y


func _draw() -> void:
	self._draw_points()
	self._draw_sticks()


func _update_points() -> void:
	for p in self._points:
		if p.pinned:
			continue
		var vx: float = (p.x - p.oldx) * self._friction
		var vy: float = (p.y - p.oldy) * self._friction
		p.oldx = p.x
		p.oldy = p.y
		p.x += vx
		p.y += vy


func _update_sticks() -> void:
	for s in self._sticks:
		var dx = s.p1.x - s.p0.x
		var dy = s.p1.y - s.p0.y
		var distance = sqrt(dx * dx + dy * dy)
		var difference = s.length - distance
		var percent = difference / distance / 2
		var offset_x = dx * percent
		var offset_y = dy * percent

		s.p0.x -= offset_x
		s.p0.y -= offset_y
		s.p1.x += offset_x
		s.p1.y += offset_y


func _draw_points() -> void:
	for p in self._points:
		draw_circle(Vector2(p.x, p.y), 5, Color.black)


func _draw_sticks() -> void:
	var from = Vector2()
	var to = Vector2()
	for s in self._sticks:
		from.x = s.p0.x
		from.y = s.p0.y
		to.x = s.p1.x
		to.y = s.p1.y
		draw_line(from, to, Color.black)
