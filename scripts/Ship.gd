# Scripts/Ship.gd
extends Area2D

var view_size: Vector2
var boundary := 32
var ongoing_drag := -1
var touch_event := Vector2.ZERO

export var ACCELERATION = 500

func _ready():
	view_size = get_viewport_rect().size
	
func _physics_process(delta: float):
	var motion := Vector2.ZERO
	
	motion = (touch_event - position) * 0.1 * delta
	motion = motion.normalized()
	
	position.x = clamp(position.x, 17, view_size.x - 17)
	
	if touch_event != Vector2.ZERO:
		if (touch_event - position).length() > 8:
			translate(motion)
		

func _input(event):
	if event is InputEventScreenDrag: #or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_ship = (event.position - position).length()
		
		if event_dist_from_ship <= boundary * global_scale.x or event.get_index() == ongoing_drag:
			ongoing_drag = event.get_index()
			touch_event = event.position
			
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1
		touch_event = Vector2.ZERO
