extends TextureButton


export var mall_name = "No Mall Name"
export(int, 6) var lots = 1

export var mouse_over_color = Color(1.5, 1.5, 1.5)
export var press_color = Color(0.8, 0.8, 0.8)

export(Texture) var deselected_texture
export(Texture) var selected_texture

export(NodePath) var name_panel_path
var name_panel

export(NodePath) var name_text_path
var name_text

const COLOR_LERP_SPEED = 20.0
var moused_over = false

var selected = false
var outlets = []

signal mall_clicked


func _ready():
	name_panel = get_node(name_panel_path)
	name_text = get_node(name_text_path)
	name_panel.hide()
	name_text.text = mall_name
	deselect()


func _process(delta):
	if moused_over:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			modulate = press_color
		else:
			modulate = modulate.linear_interpolate(mouse_over_color, COLOR_LERP_SPEED * delta)
	else:
		modulate = modulate.linear_interpolate(Color.white, COLOR_LERP_SPEED * delta)


func _on_mouse_entered():
	raise()
	moused_over = true
	name_panel.show()


func _on_mouse_exited():
	moused_over = false
	name_panel.hide()


func select():
	selected = true
	texture_normal = selected_texture


func deselect():
	selected = false
	texture_normal = deselected_texture


func _on_Mall_pressed():
	emit_signal("mall_clicked", self)
