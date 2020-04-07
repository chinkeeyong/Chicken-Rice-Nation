extends Control

export(NodePath) var camera_path
var camera

export(NodePath) var left_side_menu_path
var left_side_menu

export(NodePath) var f1_company_logo_path
var f1_company_logo
export(NodePath) var f1_company_name_path
var f1_company_name
export(NodePath) var f1_company_subtitle_path
var f1_company_subtitle
export(NodePath) var f1_company_brand_strength_path
var f1_company_brand_strength
export(NodePath) var f1_company_net_worth_path
var f1_company_net_worth
export(NodePath) var f1_rename_button_path
var f1_rename_button
export(NodePath) var f1_sabotage_button_path
var f1_sabotage_button
export(NodePath) var f1_income_tree_path
var f1_income_tree
var f1_income_tree_sales
var f1_income_tree_other
var f1_income_tree_total
export(NodePath) var f1_expenditure_tree_path
var f1_expenditure_tree
var f1_expenditure_tree_rental
var f1_expenditure_tree_other
var f1_expenditure_tree_total
export(NodePath) var f1_balance_path
var f1_balance
export(NodePath) var f1_growth_path
var f1_growth
export(NodePath) var f1_outlet_tree_path
var f1_outlet_tree

export(NodePath) var mall_viewer_path
var mall_viewer
export(NodePath) var mall_viewer_name_path
var mall_viewer_name
export(NodePath) var mall_viewer_rent_path
var mall_viewer_rent
export(NodePath) var mall_viewer_prestige_path
var mall_viewer_prestige

export(NodePath) var rename_dialog_path
var rename_dialog
export(NodePath) var rename_dialog_text_path
var rename_dialog_text

export(NodePath) var player_company_path
var player_company

export(NodePath) var map_path
var map

export(NodePath) var malls_path
var malls

var selected_company
var selected_mall
var renamed_company

const POSITIVE_MODIFIER_COLOR = Color(0.5, 1.0, 0.5)
const NEGATIVE_MODIFIER_COLOR = Color(1.0, 0.5, 0.5)
const ZERO_MODIFIER_COLOR = Color(1.0, 1.0, 1.0)


export(String, MULTILINE) var f1_income_tree_sales_tooltip
export(String, MULTILINE) var f1_income_tree_other_tooltip
export(String, MULTILINE) var f1_expenditure_tree_rental_tooltip
export(String, MULTILINE) var f1_expenditure_tree_other_tooltip


func _ready():
	show()
	
	camera = get_node(camera_path)
	
	left_side_menu = get_node(left_side_menu_path)
	
	f1_company_logo = get_node(f1_company_logo_path)
	f1_company_name = get_node(f1_company_name_path)
	f1_company_subtitle = get_node(f1_company_subtitle_path)
	f1_company_brand_strength = get_node(f1_company_brand_strength_path)
	f1_company_net_worth = get_node(f1_company_net_worth_path)
	f1_rename_button = get_node(f1_rename_button_path)
	f1_sabotage_button = get_node(f1_sabotage_button_path)
	f1_income_tree = get_node(f1_income_tree_path)
	f1_expenditure_tree = get_node(f1_expenditure_tree_path)
	f1_balance = get_node(f1_balance_path)
	f1_growth = get_node(f1_growth_path)
	f1_outlet_tree = get_node(f1_outlet_tree_path)
	
	mall_viewer = get_node(mall_viewer_path)
	mall_viewer_name = get_node(mall_viewer_name_path)
	mall_viewer_rent = get_node(mall_viewer_rent_path)
	mall_viewer_prestige = get_node(mall_viewer_prestige_path)
	
	rename_dialog = get_node(rename_dialog_path)
	rename_dialog_text = get_node(rename_dialog_text_path)
	
	player_company = get_node(player_company_path)
	
	map = get_node(map_path)
	
	malls = get_node(malls_path)
	for mall in malls.get_children():
		mall.connect("mall_clicked", self, "_on_mall_clicked")
	
	selected_company = player_company
	
	construct_f1_income_tree()
	construct_f1_expenditure_tree()
	construct_f1_outlet_tree()
	
	left_side_menu.hide()
	mall_viewer.hide()


func _input(event):
	if event.is_action_pressed("ui_menu_f1"):
		set_left_side_menu_tab(0)
	elif event.is_action_pressed("ui_menu_f2"):
		set_left_side_menu_tab(1)
	elif event.is_action_pressed("ui_cancel"):
		_on_escape()


func _on_menu_button(tab_id):
	if left_side_menu.visible && left_side_menu.current_tab == tab_id:
		left_side_menu.hide()
	else:
		set_left_side_menu_tab(tab_id)


func _on_escape():
	if left_side_menu.visible:
		left_side_menu.hide()
	select_mall(null)


func _on_RenameButton_pressed():
	if selected_company != null:
		renamed_company = selected_company
		rename_dialog_text.text = selected_company.name
		rename_dialog.popup_centered()


func _on_rename():
	renamed_company.name = rename_dialog_text.text
	f1_company_name.text = selected_company.name


func _on_mall_clicked(mall):
	select_mall(mall)


func _on_Map_input_event(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				select_mall(null)


func construct_f1_income_tree():
	f1_income_tree.set_column_title(0, "Income")
	f1_income_tree.set_column_title(1, "")
	f1_income_tree.set_column_titles_visible(true)
	var f1_income_tree_root = f1_income_tree.create_item()
	f1_income_tree_sales = f1_income_tree.create_item(f1_income_tree_root)
	f1_income_tree_sales.set_text(0, "Sales")
	f1_income_tree_sales.set_tooltip(0, f1_income_tree_sales_tooltip)
	f1_income_tree_sales.set_selectable(0, false)
	f1_income_tree_sales.set_selectable(1, false)
	f1_income_tree_other = f1_income_tree.create_item(f1_income_tree_root)
	f1_income_tree_other.set_text(0, "Other")
	f1_income_tree_other.set_tooltip(0, f1_income_tree_other_tooltip)
	f1_income_tree_other.set_selectable(0, false)
	f1_income_tree_other.set_selectable(1, false)
	var f1_income_tree_blank1 = f1_income_tree.create_item(f1_income_tree_root)
	f1_income_tree_blank1.set_selectable(0, false)
	f1_income_tree_blank1.set_selectable(1, false)
	f1_income_tree_total = f1_income_tree.create_item(f1_income_tree_root)
	f1_income_tree_total.set_text(0, "Total")
	f1_income_tree_total.set_tooltip(0, "Total Income")
	f1_income_tree_total.set_selectable(0, false)
	f1_income_tree_total.set_selectable(1, false)


func construct_f1_expenditure_tree():
	f1_expenditure_tree.set_column_title(0, "Expenditure")
	f1_expenditure_tree.set_column_title(1, "")
	f1_expenditure_tree.set_column_titles_visible(true)
	var f1_expenditure_tree_root = f1_expenditure_tree.create_item()
	f1_expenditure_tree_rental = f1_expenditure_tree.create_item(f1_expenditure_tree_root)
	f1_expenditure_tree_rental.set_text(0, "Rental")
	f1_expenditure_tree_rental.set_tooltip(0, f1_expenditure_tree_rental_tooltip)
	f1_expenditure_tree_rental.set_selectable(0, false)
	f1_expenditure_tree_rental.set_selectable(1, false)
	f1_expenditure_tree_other = f1_expenditure_tree.create_item(f1_expenditure_tree_root)
	f1_expenditure_tree_other.set_text(0, "Other")
	f1_expenditure_tree_other.set_tooltip(0, f1_expenditure_tree_other_tooltip)
	f1_expenditure_tree_other.set_selectable(0, false)
	f1_expenditure_tree_other.set_selectable(1, false)
	var f1_expenditure_tree_blank1 = f1_expenditure_tree.create_item(f1_expenditure_tree_root)
	f1_expenditure_tree_blank1.set_selectable(0, false)
	f1_expenditure_tree_blank1.set_selectable(1, false)
	f1_expenditure_tree_total = f1_expenditure_tree.create_item(f1_expenditure_tree_root)
	f1_expenditure_tree_total.set_text(0, "Total")
	f1_expenditure_tree_total.set_tooltip(0, "Total Expenditure")
	f1_expenditure_tree_total.set_selectable(0, false)
	f1_expenditure_tree_total.set_selectable(1, false)


func construct_f1_outlet_tree():
	f1_outlet_tree.set_column_title(0, "Location")
	f1_outlet_tree.set_column_title(1, "Lot #")
	f1_outlet_tree.set_column_title(2, "Customers")
	f1_outlet_tree.set_column_title(3, "Net Worth")
	f1_outlet_tree.set_column_titles_visible(true)


func set_left_side_menu_tab(tab_id):
	update_left_side_menu_tab(tab_id)
	left_side_menu.show()
	left_side_menu.current_tab = tab_id


func update_left_side_menu_tab(tab_id):
	match tab_id:
		0:
			update_f1()
		1:
			update_f2()


func update_f1():
	f1_company_logo.texture = selected_company.logo
	f1_company_name.text = selected_company.name
	f1_company_subtitle.text = selected_company.subtitle
	f1_company_brand_strength.text = to_1_significant_digit(selected_company.brand_strength)
	f1_company_net_worth.text = money_string(selected_company.net_worth)
	f1_company_net_worth.set("custom_colors/font_color", positive_negative_color(selected_company.net_worth))
	if selected_company == player_company:
		f1_rename_button.show()
		f1_sabotage_button.hide()
	else:
		f1_rename_button.hide()
		f1_sabotage_button.show()
	update_f1_finances()
	update_f1_outlets()


func update_f1_finances():
	f1_income_tree_sales.set_text(1, signed_money_string(selected_company.income_sales))
	f1_income_tree_sales.set_custom_color(1, positive_negative_color(selected_company.income_sales))
	f1_income_tree_other.set_text(1, signed_money_string(selected_company.income_other))
	f1_income_tree_other.set_custom_color(1, positive_negative_color(selected_company.income_other))
	f1_income_tree_total.set_text(1, signed_money_string(selected_company.income))
	f1_income_tree_total.set_custom_color(1, positive_negative_color(selected_company.income))
	f1_expenditure_tree_rental.set_text(1, signed_money_string(selected_company.expenditure_rental))
	f1_expenditure_tree_rental.set_custom_color(1, positive_negative_color(selected_company.expenditure_rental))
	f1_expenditure_tree_other.set_text(1, signed_money_string(selected_company.expenditure_other))
	f1_expenditure_tree_other.set_custom_color(1, positive_negative_color(selected_company.expenditure_other))
	f1_expenditure_tree_total.set_text(1, signed_money_string(selected_company.expenditure))
	f1_expenditure_tree_total.set_custom_color(1, positive_negative_color(selected_company.expenditure))
	f1_balance.text = signed_money_string(selected_company.balance)
	f1_balance.set("custom_colors/font_color", positive_negative_color(selected_company.balance))
	f1_growth.text = signed_percentile_string(selected_company.growth)
	f1_growth.set("custom_colors/font_color", positive_negative_color(selected_company.growth))


func update_f1_outlets():
	pass


func update_f2():
	pass


func update_mall_viewer():
	if selected_mall != null:
		mall_viewer_name.text = selected_mall.name
		mall_viewer_rent.text = money_string(selected_mall.rent)
		mall_viewer_prestige.text = to_1_significant_digit(selected_mall.prestige)


func select_mall(mall):
	
	if selected_mall != null:
		selected_mall.deselect()
	
	if mall != null:
		selected_mall = mall
		mall.select()
		mall_viewer.show()
		update_mall_viewer()
	else:
		selected_mall = null
		mall_viewer.hide()


# warning-ignore:unused_argument
func to_1_significant_digit(number):
	number *= 10
	number = round(number)
	var digit = int(number) % 10
	number /= 10.0
	number = int(number)
	return "%s.%s" % [comma_sep(number), digit]


# warning-ignore:unused_argument
func positive_negative_color(amount):
	amount *= 100
	amount = round(amount)
	amount /= 100.0
	if amount > 0:
		return POSITIVE_MODIFIER_COLOR
	elif amount < 0:
		return NEGATIVE_MODIFIER_COLOR
	else:
		return ZERO_MODIFIER_COLOR


func money_string(dollars):
	dollars *= 100
	dollars = round(dollars)
	var cents = int(dollars) % 100
	dollars /= 100.0
	dollars = int(dollars)
	if dollars > 0:
		return "$%s.%s" % [comma_sep(dollars), cents]
	elif dollars < 0:
		return "$%s.%s" % [comma_sep(dollars), cents]
	else:
		return "$0.00"


func signed_money_string(dollars):
	dollars *= 100
	dollars = round(dollars)
	var cents = int(dollars) % 100
	dollars /= 100.0
	dollars = int(dollars)
	if dollars > 0:
		return "+$%s.%s" % [comma_sep(dollars), cents]
	elif dollars < 0:
		return "-$%s.%s" % [comma_sep(dollars), cents]
	else:
		return "$0.00"


func signed_percentile_string(number):
	number *= 1000
	number = round(number)
	var cents = int(number) % 10
	number /= 10.0
	number = int(number)
	if number > 0:
		return "+%s.%s%" % [comma_sep(number), cents]
	elif number < 0:
		return "-%s.%s%" % [comma_sep(number), cents]
	else:
		return "0.0%"

func comma_sep(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""
	
	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]
	
	return res
