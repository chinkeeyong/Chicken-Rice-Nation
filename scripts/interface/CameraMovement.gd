extends Camera2D


export var pan_speed = 30.0
export var zoom_speed = 0.2
export var max_zoom = 1.0
export var min_zoom = 1.0
export var position_lerp_amount = 1.0
export var zoom_lerp_amount = 1.0

export(Texture) var map_texture

export(NodePath) var malls_path
var malls

var viewport_left_bound = 1
var viewport_up_bound = 1
var viewport_right_bound = 0
var viewport_down_bound = 0
var target_zoom
var target_position


func _ready():
	
	malls = get_node(malls_path)
	for mall in malls.get_children():
		mall.connect("gui_input", self, "_on_Map_input_event")
	
	viewport_right_bound = get_viewport_rect().size.x - 1
	viewport_down_bound = get_viewport_rect().size.y - 1
	
	target_zoom = zoom
	target_position = position


func _process(delta):
	
	# Panning
	var panning_velocity = Vector2.ZERO
	var mouse_position = get_viewport().get_mouse_position()
	if Input.is_action_pressed("ui_left") || mouse_position.x <= viewport_left_bound:
		panning_velocity.x -= pan_speed
	if Input.is_action_pressed("ui_right") || mouse_position.x >= viewport_right_bound:
		panning_velocity.x += pan_speed
	if Input.is_action_pressed("ui_up") || mouse_position.y <= viewport_up_bound:
		panning_velocity.y -= pan_speed
	if Input.is_action_pressed("ui_down") || mouse_position.y >= viewport_down_bound:
		panning_velocity.y += pan_speed
	panning_velocity *= zoom.x
	target_position += panning_velocity * pan_speed * delta
	
	# Apply zoom
	zoom = zoom.linear_interpolate(target_zoom, zoom_lerp_amount * delta)
	for mall in malls.get_children():
		mall.rect_scale = zoom
	
	# Clamp to map bounds
	target_position.x = clamp(target_position.x,
			(map_texture.get_width() * -0.5) + (get_viewport_rect().size.x * zoom.x / 2),
			(map_texture.get_width() * 0.5) - (get_viewport_rect().size.x * zoom.x / 2))
	target_position.y = clamp(target_position.y,
			(map_texture.get_height() * -0.5) + (get_viewport_rect().size.y * zoom.y / 2),
			(map_texture.get_height() * 0.5) - (get_viewport_rect().size.y * zoom.y / 2))
	
	# Finally, apply all transformation to position
	position = position.linear_interpolate(target_position, position_lerp_amount * delta)


func _on_Map_input_event(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP && target_zoom.x > min_zoom:
				target_zoom -= Vector2(zoom_speed, zoom_speed)
				if target_zoom.x < min_zoom:
					target_zoom = Vector2(min_zoom, min_zoom)
			elif event.button_index == BUTTON_WHEEL_DOWN && target_zoom.x < max_zoom:
				target_zoom += Vector2(zoom_speed, zoom_speed)
				if target_zoom.x > max_zoom:
					target_zoom = Vector2(max_zoom, max_zoom)
