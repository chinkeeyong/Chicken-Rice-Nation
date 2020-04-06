extends TextureButton

export(int, 6) var lots = 6

export var press_color = Color(0.8, 0.8, 0.8)

export(Texture) var deselected_texture
export(Texture) var selected_texture

var name_panel
var name_text

const COLOR_LERP_SPEED = 20.0
var moused_over = false

var selected = false
var outlets = []

signal mall_clicked


func _ready():
	name_panel = $NamePanel
	name_text = $NamePanel/NameText
	name_panel.hide()
	name_text.text = name
	deselect()


func _process(delta):
	if moused_over:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			self_modulate = press_color
		else:
			self_modulate = Color.white


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
