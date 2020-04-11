extends Control

class_name GUI

export(NodePath) var camera_path
var camera

export(NodePath) var cash_counter_path
var cash_counter
export(NodePath) var suspicion_counter_path
var suspicion_counter

export(NodePath) var left_side_menu_path
var left_side_menu

export(NodePath) var f1_company_logo_path
var f1_company_logo
export(NodePath) var f1_company_name_path
var f1_company_name
export(NodePath) var f1_company_subtitle_path
var f1_company_subtitle
export(NodePath) var f1_company_cash_path
var f1_company_cash
export(NodePath) var f1_company_suspicion_path
var f1_company_suspicion
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
var f1_income_tree_liquidation
var f1_income_tree_other
var f1_income_tree_total
export(NodePath) var f1_expenditure_tree_path
var f1_expenditure_tree
var f1_expenditure_tree_rental
var f1_expenditure_tree_acquisition
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
export(NodePath) var mall_viewer_revenue_path
var mall_viewer_revenue
export(NodePath) var mall_viewer_prestige_path
var mall_viewer_prestige
export(NodePath) var mall_viewer_customers_path
var mall_viewer_customers
export(NodePath) var mall_viewer_lots_path
var mall_viewer_lots

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
export(String, MULTILINE) var f1_income_tree_liquidation_tooltip
export(String, MULTILINE) var f1_income_tree_other_tooltip
export(String, MULTILINE) var f1_expenditure_tree_rental_tooltip
export(String, MULTILINE) var f1_expenditure_tree_acquisition_tooltip
export(String, MULTILINE) var f1_expenditure_tree_other_tooltip


func _ready():
	show()
	
	camera = get_node(camera_path)
	
	cash_counter = get_node(cash_counter_path)
	suspicion_counter = get_node(suspicion_counter_path)
	
	left_side_menu = get_node(left_side_menu_path)
	
	f1_company_logo = get_node(f1_company_logo_path)
	f1_company_name = get_node(f1_company_name_path)
	f1_company_subtitle = get_node(f1_company_subtitle_path)
	f1_company_cash = get_node(f1_company_cash_path)
	f1_company_suspicion = get_node(f1_company_suspicion_path)
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
	mall_viewer_revenue = get_node(mall_viewer_revenue_path)
	mall_viewer_prestige = get_node(mall_viewer_prestige_path)
	mall_viewer_customers = get_node(mall_viewer_customers_path)
	mall_viewer_lots = get_node(mall_viewer_lots_path)
	for lot in mall_viewer_lots.get_children():
		lot.connect("BuyLotButton_pressed", self, "_on_lot_BuyLotButton_pressed")
		lot.connect("BuyoutButton_pressed", self, "_on_lot_BuyoutButton_pressed")
		lot.connect("OwnerName_pressed", self, "_on_lot_OwnerName_pressed")
	
	rename_dialog = get_node(rename_dialog_path)
	rename_dialog_text = get_node(rename_dialog_text_path)
	
	player_company = get_node(player_company_path)
	player_company.connect("cash_changed", self, "_on_player_cash_changed")
	player_company.connect("suspicion_changed", self, "_on_player_suspicion_changed")
	
	map = get_node(map_path)
	
	malls = get_node(malls_path)
	for mall in malls.get_children():
		mall.connect("mall_clicked", self, "_on_mall_clicked")
	
	selected_company = player_company
	
	construct_f1_income_tree()
	construct_f1_expenditure_tree()
	construct_f1_outlet_tree()
	update_cash_counter()
	update_suspicion_counter()
	
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
	if tab_id == 0 && selected_company != player_company:
		selected_company = player_company
		set_left_side_menu_tab(tab_id)
	elif left_side_menu.visible && left_side_menu.current_tab == tab_id:
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


func _on_Mall_Name_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				camera.target_position = selected_mall.rect_position


func _on_player_cash_changed():
	update_cash_counter()


func _on_player_suspicion_changed():
	update_suspicion_counter()


func _on_lot_BuyLotButton_pressed(lot):
	player_company.create_outlet(lot.associated_mall, lot.lot_id)
	player_company.cash -= lot.cost
	player_company.expenditure_acquisition -= lot.cost
	player_company.calc_net_worth()
	update_mall_viewer()
	update_f1()


func _on_lot_BuyoutButton_pressed(lot):
	if lot.associated_outlet != null:
		lot.associated_outlet.destroy()
		if lot.associated_outlet.get_parent() == player_company: # Selling the lot
			player_company.cash += lot.cost
			player_company.income_liquidation += lot.cost
		else:
			player_company.create_outlet(lot.associated_mall, lot.lot_id)
			player_company.cash -= lot.cost
			player_company.expenditure_acquisition -= lot.cost
		player_company.calc_net_worth()
		update_mall_viewer()
		update_f1()

func _on_lot_OwnerName_pressed(lot):
	if lot.associated_outlet != null:
		selected_company = lot.associated_outlet.get_parent()
		set_left_side_menu_tab(0)


func _on_f1_outlet_tree_cell_selected():
	var selected_cell = f1_outlet_tree.get_selected()
	var selected_cell_mall = malls.find_node(selected_cell.get_text(0), false, true)
	select_mall(selected_cell_mall)
	camera.target_position = selected_mall.rect_position
	for i in range(4):
		selected_cell.deselect(i)


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
	f1_income_tree_liquidation = f1_income_tree.create_item(f1_income_tree_root)
	f1_income_tree_liquidation.set_text(0, "Liquidation")
	f1_income_tree_liquidation.set_tooltip(0, f1_income_tree_liquidation_tooltip)
	f1_income_tree_liquidation.set_selectable(0, false)
	f1_income_tree_liquidation.set_selectable(1, false)
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
	f1_expenditure_tree_acquisition = f1_expenditure_tree.create_item(f1_expenditure_tree_root)
	f1_expenditure_tree_acquisition.set_text(0, "Acquisition")
	f1_expenditure_tree_acquisition.set_tooltip(0, f1_expenditure_tree_acquisition_tooltip)
	f1_expenditure_tree_acquisition.set_selectable(0, false)
	f1_expenditure_tree_acquisition.set_selectable(1, false)
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
	f1_outlet_tree.set_column_title(1, "Lot")
	f1_outlet_tree.set_column_title(2, "Customers")
	f1_outlet_tree.set_column_title(3, "Net Worth")
	f1_outlet_tree.set_column_titles_visible(true)
	f1_outlet_tree.set_column_min_width(1, 32)
	f1_outlet_tree.set_column_min_width(2, 96)
	f1_outlet_tree.set_column_min_width(3, 96)
	for i in range (1, 4):
		f1_outlet_tree.set_column_expand(i, false)


func set_left_side_menu_tab(tab_id):
	update_left_side_menu_tab(tab_id)
	left_side_menu.show()
	left_side_menu.current_tab = tab_id


func update_cash_counter():
	cash_counter.text = money_string(player_company.cash)
	cash_counter.set("custom_colors/font_color", positive_negative_color(player_company.cash))


func update_suspicion_counter():
	suspicion_counter.text = to_1_significant_digit(player_company.suspicion)


func update_left_side_menu_tab(tab_id):
	match tab_id:
		0:
			update_f1()
		1:
			update_f2()


func update_f1():
	selected_company.calc_balance()
	f1_company_logo.texture = selected_company.logo
	f1_company_name.text = selected_company.name
	f1_company_subtitle.text = selected_company.subtitle
	f1_company_cash.text = money_string(selected_company.cash)
	f1_company_cash.set("custom_colors/font_color", positive_negative_color(selected_company.cash))
	f1_company_suspicion.text = to_1_significant_digit(selected_company.suspicion)
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
	f1_income_tree_liquidation.set_text(1, signed_money_string(selected_company.income_liquidation))
	f1_income_tree_liquidation.set_custom_color(1, positive_negative_color(selected_company.income_liquidation))
	f1_income_tree_other.set_text(1, signed_money_string(selected_company.income_other))
	f1_income_tree_other.set_custom_color(1, positive_negative_color(selected_company.income_other))
	f1_income_tree_total.set_text(1, signed_money_string(selected_company.income))
	f1_income_tree_total.set_custom_color(1, positive_negative_color(selected_company.income))
	f1_expenditure_tree_rental.set_text(1, signed_money_string(selected_company.expenditure_rental))
	f1_expenditure_tree_rental.set_custom_color(1, positive_negative_color(selected_company.expenditure_rental))
	f1_expenditure_tree_acquisition.set_text(1, signed_money_string(selected_company.expenditure_acquisition))
	f1_expenditure_tree_acquisition.set_custom_color(1, positive_negative_color(selected_company.expenditure_acquisition))
	f1_expenditure_tree_other.set_text(1, signed_money_string(selected_company.expenditure_other))
	f1_expenditure_tree_other.set_custom_color(1, positive_negative_color(selected_company.expenditure_other))
	f1_expenditure_tree_total.set_text(1, signed_money_string(selected_company.expenditure))
	f1_expenditure_tree_total.set_custom_color(1, positive_negative_color(selected_company.expenditure))
	f1_balance.text = signed_money_string(selected_company.balance)
	f1_balance.set("custom_colors/font_color", positive_negative_color(selected_company.balance))
	var f1_growth_number = signed_percentile_string(selected_company.growth)
	f1_growth.text = "%s (Negative Quarters: %s)" % [f1_growth_number, selected_company.quarters_without_growth]
	f1_growth.set("custom_colors/font_color", positive_negative_color(selected_company.growth))


func update_f1_outlets():
	f1_outlet_tree.clear()
	var f1_outlet_tree_root = f1_outlet_tree.create_item()
	for outlet in selected_company.outlets:
		var outlet_tree_item = f1_outlet_tree.create_item(f1_outlet_tree_root)
		outlet_tree_item.set_text(0, outlet.location.name)
		outlet_tree_item.set_text(1, String(outlet.lot_id + 1))
		outlet_tree_item.set_text(2, "%s/%s" % [outlet.customers, outlet.max_customers])
		outlet_tree_item.set_text(3, money_string(outlet.net_worth))
		for i in range(4):
			outlet_tree_item.set_tooltip(i, "Click to select the Mall this Outlet is in.")
		for i in range(2,3):
			outlet_tree_item.set_text_align(i, TreeItem.ALIGN_CENTER)


func update_f2():
	pass


func update_mall_viewer():
	if selected_mall != null:
		mall_viewer_name.text = selected_mall.name
		mall_viewer_rent.text = money_string(selected_mall.rent)
		mall_viewer_revenue.text = money_string(selected_mall.revenue)
		mall_viewer_prestige.text = to_1_significant_digit(selected_mall.prestige)
		mall_viewer_customers.text = String(selected_mall.customers)
		
		for i in range(6):
			mall_viewer_lots.get_child(i).show_outlet(selected_mall, selected_mall.lots[i])


func select_mall(mall):
	
	if selected_mall != null:
		selected_mall.deselect()
	
	if mall != null:
		selected_mall = mall
		selected_mall.select()
		mall_viewer.show()
		update_mall_viewer()
	else:
		selected_mall = null
		mall_viewer.hide()


# warning-ignore:unused_argument
static func to_1_significant_digit(number):
	number *= 10
	number = round(number)
	var digit = int(number) % 10
	number /= 10.0
	number = int(number)
	return "%s.%s" % [comma_sep(number), abs(digit)]


# warning-ignore:unused_argument
static func positive_negative_color(amount):
	amount *= 100
	amount = round(amount)
	amount /= 100.0
	if amount > 0:
		return POSITIVE_MODIFIER_COLOR
	elif amount < 0:
		return NEGATIVE_MODIFIER_COLOR
	else:
		return ZERO_MODIFIER_COLOR


static func money_string(dollars):
	dollars = int(dollars)
	if dollars > 0:
		return "$%s" % comma_sep(abs(dollars))
	elif dollars < 0:
		return "-$%s" % comma_sep(abs(dollars))
	else:
		return "$0"


static func signed_money_string(dollars):
	dollars = int(dollars)
	if dollars > 0:
		return "+$%s" % comma_sep(abs(dollars))
	elif dollars < 0:
		return "-$%s" % comma_sep(abs(dollars))
	else:
		return "$0"


static func signed_percentile_string(number):
	number *= 1000
	number = round(number)
	var cents = int(number) % 10
	number /= 10.0
	number = int(number)
	if number > 0:
		return "+%s.%s%%" % [comma_sep(abs(number)), leading_zeroes(abs(cents), 1)]
	elif number < 0:
		return "-%s.%s%%" % [comma_sep(abs(number)), leading_zeroes(abs(cents), 1)]
	else:
		return "0.0%"

static func comma_sep(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""
	
	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]
	
	return res

static func leading_zeroes(number, length):
	var res = String(number)
	while res.length() < length:
		res = res.insert(0, "0")
	return res
