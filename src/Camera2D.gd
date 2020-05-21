extends Camera2D
class_name MainCamera

signal camera_moved(vector)

var _previousPosition: Vector2 = Vector2(0, 0);
var _moveCamera: bool = false;

func _ready():
	current = true

	#$".".get_parent().get_child(1).connect("camera_moved",self,"_on_MainCamera_moved",[position])

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		get_tree().set_input_as_handled();
		if event.is_pressed():
			_previousPosition = event.position;
			_moveCamera = true;
		else:
			_moveCamera = false;
	elif event is InputEventMouseMotion && _moveCamera:
		get_tree().set_input_as_handled();
		position += (_previousPosition - event.position);
		_previousPosition = event.position;
		emit_signal("camera_moved",position)
	if event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_UP:
		var cam_vec = get_zoom()
		if(cam_vec.x != 1):
			set_zoom(Vector2(cam_vec.x-1,cam_vec.y-1))
	elif event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_DOWN:
		var cam_vec = get_zoom()
		set_zoom(Vector2(cam_vec.x+1,cam_vec.y+1))
