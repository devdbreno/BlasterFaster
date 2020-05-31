# Scripts/Ship.gd
extends Area2D

var view_size: Vector2
var radius = Vector2(16, 16)
var boundary = 32
var ongoing_drag = -1
var event_pos: Vector2

func _ready():
	view_size = get_viewport_rect().size
	event_pos = position
	pass

func _physics_process(delta: float):
	var motion: Vector2
	
	var motion_x = (event_pos.x - position.x) * 0.25
	var motion_y = ((event_pos.y - 20) - position.y) * 0.25
	
	motion = Vector2(motion_x, motion_y)

	motion.normalized()
	
	translate(motion)
	
	pass

################################################################################
#var return_accel = 20
#var threshold = 10
#func get_button_pos():
#	return position + radius

func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_ship = (event.position - position).length()
		
		if event_dist_from_ship <= boundary * global_scale.x or event.get_index() == ongoing_drag:
			ongoing_drag = event.get_index()
			event_pos = event.position
			pass
			
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1
		
#func get_value():
#	if get_button_pos().length() > threshold:
#		return get_button_pos().normalized()
#
#	return Vector2(0, 0)
