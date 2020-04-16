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
export(NodePath) var f1_company_control_path
var f1_company_control
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
export(NodePath) var f1_outlets_tab_path
var f1_outlets_tab
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

export(NodePath) var date_stamp_path
var date_stamp
export(NodePath) var time_stamp_path
var time_stamp

export(NodePath) var rename_dialog_path
var rename_dialog
export(NodePath) var rename_dialog_text_path
var rename_dialog_text

export(NodePath) var event_dialog_path
var event_dialog
export(NodePath) var event_text_path
var event_text
export(NodePath) var event_effects_path
var event_effects

export(NodePath) var sabotage_dialog_path
var sabotage_dialog
export(NodePath) var sabotage_text_path
var sabotage_text
export(NodePath) var sabotage_effects_path
var sabotage_effects

export(NodePath) var player_company_path
var player_company

export(NodePath) var map_path
var map

export(NodePath) var malls_path
var malls

var total_outlets
var selected_company
var selected_mall
var renamed_company
var current_sabotage_event

const POSITIVE_MODIFIER_COLOR = Color(0.5, 1.0, 0.5)
const NEGATIVE_MODIFIER_COLOR = Color(1.0, 0.5, 0.5)
const ZERO_MODIFIER_COLOR = Color(1.0, 1.0, 1.0)

signal Next_Month_Button_pressed


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
	f1_company_control = get_node(f1_company_control_path)
	f1_rename_button = get_node(f1_rename_button_path)
	f1_sabotage_button = get_node(f1_sabotage_button_path)
	f1_income_tree = get_node(f1_income_tree_path)
	f1_expenditure_tree = get_node(f1_expenditure_tree_path)
	f1_balance = get_node(f1_balance_path)
	f1_growth = get_node(f1_growth_path)
	f1_outlets_tab = get_node(f1_outlets_tab_path)
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
	
	date_stamp = get_node(date_stamp_path)
	time_stamp = get_node(time_stamp_path)
	
	rename_dialog = get_node(rename_dialog_path)
	rename_dialog_text = get_node(rename_dialog_text_path)
	
	event_dialog = get_node(event_dialog_path)
	event_text = get_node(event_text_path)
	event_effects = get_node(event_effects_path)
	
	sabotage_dialog = get_node(sabotage_dialog_path)
	sabotage_text = get_node(sabotage_text_path)
	sabotage_effects = get_node(sabotage_effects_path)
	
	player_company = get_node(player_company_path)
	player_company.connect("cash_changed", self, "_on_player_cash_changed")
	player_company.connect("suspicion_changed", self, "_on_player_suspicion_changed")
	
	map = get_node(map_path)
	
	malls = get_node(malls_path)
	for mall in malls.get_children():
		mall.connect("mall_clicked", self, "_on_mall_clicked")
	
	total_outlets = malls.get_child_count() * 6
	
	selected_company = player_company
	
	construct_f1_income_tree()
	construct_f1_expenditure_tree()
	construct_f1_outlet_tree()
	update_cash_counter()
	update_suspicion_counter()
	
	left_side_menu.hide()
	mall_viewer.hide()


# warning-ignore:unused_argument
func _process(delta):
	var time_dict = OS.get_time()
	var hour = time_dict.get("hour")
	var minute = time_dict.get("minute")
	var pm = false
	if hour > 12:
		hour -= 12
		pm = true
	if pm:
		time_stamp.text = "%s:%s PM" % [hour, leading_zeroes(minute, 2)]
	else:
		time_stamp.text = "%s:%s AM" % [hour, leading_zeroes(minute, 2)]


func _input(event):
	if event.is_action_pressed("ui_menu_f1"):
		set_left_side_menu_tab(0)
	elif event.is_action_pressed("ui_menu_f2"):
		set_left_side_menu_tab(1)
	elif event.is_action_pressed("ui_next_month"):
		_on_Next_Month_Button_pressed()
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
	player_company.calc_growth()
	update_mall_viewer()
	update_f1()


func _on_lot_BuyoutButton_pressed(lot):
	if lot.associated_outlet != null:
		lot.associated_outlet.destroy()
		if lot.associated_outlet.get_parent() == player_company: # Selling the lot
			player_company.cash += lot.cost
			player_company.income_liquidation += lot.cost
		else:
			lot.associated_outlet.get_parent().cash += lot.cost
			lot.associated_outlet.get_parent().income_liquidation += lot.cost
			lot.associated_outlet.get_parent().calc_net_worth()
			lot.associated_outlet.get_parent().calc_growth()
			player_company.create_outlet(lot.associated_mall, lot.lot_id)
			player_company.cash -= lot.cost
			player_company.expenditure_acquisition -= lot.cost
		player_company.calc_net_worth()
		player_company.calc_growth()
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


func _on_Next_Month_Button_pressed():
	emit_signal("Next_Month_Button_pressed")


func _on_Sabotage_Button_pressed():
	player_company.suspicion += 0.1
	offer_sabotage()


func _on_Sabotage_Dialog_confirmed():
	confirm_sabotage()


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
	f1_outlet_tree.set_column_title(3, "Revenue")
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
	if selected_company != null:
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
		f1_company_control.text = percentile_string(float(selected_company.outlets.size()) / total_outlets)
		f1_outlets_tab.name = "Outlets (%s)" % selected_company.outlets.size()
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
	f1_growth.text = "%s (Negative Months: %s)" % [f1_growth_number, selected_company.months_without_growth]
	f1_growth.set("custom_colors/font_color", positive_negative_color(selected_company.growth))


func update_f1_outlets():
	f1_outlet_tree.clear()
	var f1_outlet_tree_root = f1_outlet_tree.create_item()
	for outlet in selected_company.outlets:
		var outlet_tree_item = f1_outlet_tree.create_item(f1_outlet_tree_root)
		outlet_tree_item.set_text(0, outlet.location.name)
		outlet_tree_item.set_text(1, String(outlet.lot_id + 1))
		outlet_tree_item.set_text(2, "%s/%s" % [outlet.customers, outlet.max_customers])
		outlet_tree_item.set_text(3, money_string(outlet.location.revenue))
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


func update_date_stamp(month, year):
	var month_name = "Unknown Month"
	match month:
		1:
			month_name = "January"
		2:
			month_name = "February"
		3:
			month_name = "March"
		4:
			month_name = "April"
		5:
			month_name = "May"
		6:
			month_name = "June"
		7:
			month_name = "July"
		8:
			month_name = "August"
		9:
			month_name = "September"
		10:
			month_name = "October"
		11:
			month_name = "November"
		12:
			month_name = "December"
	date_stamp.text = "%s %s" % [month_name, year]


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


func random_event():
	randomize()
	var id = randi() % 8
	match id:
		0:
			var cash_lost = player_company.income / 2
			player_company.add_expenditure_other(-cash_lost)
			event_dialog.window_title = "Supplier Shipment Lost"
			event_text.text = "One of your supplier's shipping vessels was involved in an accident. You've been forced to make up for the shortfall by buying at a markup."
			event_effects.text = "Cash -$%s" % cash_lost
		1:
			player_company.suspicion += 1
			player_company.brand_strength -= 0.5
			event_dialog.window_title = "Outlet Scandal"
			event_text.text = "One of your outlets was revealed to have cockroaches on social media. The incident has your marketing department scrambling for damage control."
			event_effects.text = "Suspicion +1\nBrand Strength -0.5"
		2:
			player_company.brand_strength += 1
			event_dialog.window_title = "Viral Video"
			event_text.text = "Thanks to some questionable voice acting, one of your advertisements has gone viral on YouTube. This has significantly cemented your brand in the public consciousness."
			event_effects.text = "Brand Strength +1"
		3:
			var cash_gained = player_company.income / 5
			player_company.add_income_other(cash_gained)
			event_dialog.window_title = "Investment Returns"
			event_text.text = "You have used some of your company funds to make long-term investments. Recently, your investments have really begun to pay off."
			event_effects.text = "Cash +$%s" % cash_gained
		4:
			var cash_lost = player_company.income
			player_company.add_expenditure_other(-cash_lost)
			event_dialog.window_title = "Recession"
			event_text.text = "A collapsing bubble has caused global markets to go on the downturn. Your business has suffered severely and been forced to lay off many employees."
			event_effects.text = "Cash -$%s" % cash_lost
		5:
			player_company.suspicion += 1
			event_dialog.window_title = "Media Scrutiny"
			event_text.text = "A journalist has written a series of articles about the alleged poor hygiene in your stores. While nothing is provable, your company has come under scrutiny."
			event_effects.text = "Suspicion +1"
		6:
			var cash_lost = player_company.expenditure / 2
			player_company.add_expenditure_other(cash_lost)
			event_dialog.window_title = "Outlet Repairs"
			event_text.text = "One of your outlets was revealed to have serious structural safety issues. Although the mall quickly resolved the issue, you were forced to remodel the outlet at company cost."
			event_effects.text = "Cash -$%s" % abs(cash_lost)
		7:
			player_company.brand_strength -= 5
			event_dialog.window_title = "Employee Scandal"
			event_text.text = "A group of disgruntled employees spoke out against alleged harassment in your company. While you were able to win the lawsuit, your reputation has taken a serious hit."
			event_effects.text = "Brand Strength -5"
		_:
			event_dialog.window_title = "Invalid Event"
			event_text.text = "Bad event id"
			event_effects.text = ""
	event_dialog.popup_centered()


func offer_sabotage():
	randomize()
	current_sabotage_event = randi() % 6
	match current_sabotage_event:
		0:
			sabotage_text.text = "You can hire thugs to vandalize the company's property and destroy their machinery. This will likely cost them a fortune in repairs."
			sabotage_effects.text = "Your Suspicion +1\nYour Cash -$500\nTheir Cash -$5000"
		1:
			sabotage_text.text = "You can pay a group of hackers to vandalize the company's social media pages and spread damaging rumors about their business practices."
			sabotage_effects.text = "Your Suspicion +1\nYour Cash -$5000\nTheir Brand Strength -5"
		2:
			sabotage_text.text = "You can plant cockroach and fly eggs in a corner of the company's outlet to damage their reputation."
			sabotage_effects.text = "Your Suspicion +1\nYour Cash -$2500\nTheir Brand Strength -5"
		3:
			sabotage_text.text = "You can hire a corporate spy to doctor the company's finances and siphon their funds to your company."
			sabotage_effects.text = "Your Suspicion +5\nYour Cash +$5000\nTheir Cash -$10000"
		4:
			sabotage_text.text = "You can attempt to assassinate one of the company's key decision makers, sending their organization into disarray."
			sabotage_effects.text = "Your Suspicion +5\nYour Cash -$5000\nTheir Cash -20% of Total\nTheir Brand Strength -5"
		5:
			sabotage_text.text = "You have uncovered documents that will allow you to blackmail and harass one of the company's managers into resigning."
			sabotage_effects.text = "Your Suspicion +1\nTheir Brand Strength -5"
		_:
			sabotage_dialog.window_title = "Invalid Event"
			sabotage_text.text = "Bad event id"
			sabotage_effects.text = ""
	sabotage_dialog.popup_centered()


func confirm_sabotage():
	match current_sabotage_event:
		0:
			player_company.suspicion += 1
			player_company.add_expenditure_other(-500)
			selected_company.add_expenditure_other(-5000)
		1:
			player_company.suspicion += 1
			player_company.add_expenditure_other(-5000)
			selected_company.brand_strength -= 5
		2:
			player_company.suspicion += 1
			player_company.add_expenditure_other(-2500)
			selected_company.brand_strength -= 5
		3:
			player_company.suspicion += 5
			player_company.add_income_other(5000)
			selected_company.add_expenditure_other(-10000)
		4:
			player_company.suspicion += 5
			player_company.add_expenditure_other(-5000)
			selected_company.add_expenditure_other(-abs(selected_company.cash) / 5)
			selected_company.brand_strength -= 5
		5:
			player_company.suspicion += 1
			selected_company.brand_strength -= 5
	update_f1()
	update_mall_viewer()


func suspicion_penalty_event():
	var cash_lost = int(player_company.income * player_company.suspicion / 10)
	if cash_lost < 5000:
		cash_lost = 5000
	player_company.add_expenditure_other(-cash_lost)
	event_dialog.window_title = "Excessive Suspicion"
	event_text.text = "Your company is being investigated for unethical business practices and you are being forced to spend an exorbitant amount on legal defense costs."
	event_effects.text = "Cash -$%s" % cash_lost
	event_dialog.popup_centered()


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


static func percentile_string(number):
	number *= 1000
	number = round(number)
	var cents = int(number) % 10
	number /= 10.0
	number = int(number)
	return "%s.%s%%" % [comma_sep(abs(number)), leading_zeroes(abs(cents), 1)]


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
