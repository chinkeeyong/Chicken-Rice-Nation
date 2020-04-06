extends TextureButton

export var mouse_over_color = Color(1.5, 1.5, 1.5)
export var press_color = Color(0.8, 0.8, 0.8)
const COLOR_LERP_SPEED = 20.0
var moused_over = false

func _process(delta):
	if (pressed):
		modulate = press_color
	else:
		if (moused_over):
			modulate = modulate.linear_interpolate(mouse_over_color, COLOR_LERP_SPEED * delta)
		else:
			modulate = modulate.linear_interpolate(Color.white, COLOR_LERP_SPEED * delta)

func _on_mouse_entered():
	moused_over = true

func _on_mouse_exited():
	moused_over = false