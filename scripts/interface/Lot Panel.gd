extends PanelContainer

onready var lot_id_label = get_node("VBoxContainer/Lot Id")
onready var occupied_text = get_node("VBoxContainer/OccupiedText")
onready var unoccupied_text = get_node("VBoxContainer/UnoccupiedText")
onready var owner_name = get_node("VBoxContainer/OccupiedText/HBoxContainer/Owner Name")
onready var owner_logo = get_node("VBoxContainer/OccupiedText/HBoxContainer/Owner Logo")
onready var customers = get_node("VBoxContainer/OccupiedText/Stats/Customers Value")
onready var net_worth = get_node("VBoxContainer/OccupiedText/Stats/Net Worth Value")
onready var buyout_button = get_node("VBoxContainer/OccupiedText/BuyoutButton")
onready var buy_lot_button = get_node("VBoxContainer/UnoccupiedText/BuyLotButton")
onready var gui = get_node("/root/Game/GUI Canvas Layer/GUI")

var associated_mall
var associated_outlet
var cost = 0

export var lot_id = 0

signal OwnerName_pressed
signal BuyLotButton_pressed
signal BuyoutButton_pressed

func _ready():
	lot_id_label.text = "Lot #%s" % lot_id

func show_outlet(mall, outlet):
	associated_mall = mall
	associated_outlet = outlet
	if outlet == null:
		cost = associated_mall.rent * 2
		buy_lot_button.text = "Buy Lot (%s)" % GUI.money_string(cost)
		buy_lot_button.disabled = cost > gui.player_company.cash
		if buy_lot_button.disabled:
			buy_lot_button.hint_tooltip = "You don't have enough Cash to open a new Outlet here."
		else:
			buy_lot_button.hint_tooltip = "Open a new Outlet in Lot %s of %s for %s." % [String(lot_id), associated_mall.name, GUI.money_string(cost)]
		occupied_text.hide()
		unoccupied_text.show()
	else:
		owner_name.text = associated_outlet.get_parent().name
		owner_logo.texture = associated_outlet.get_parent().logo
		customers.text = "%s/%s" % [associated_outlet.customers, associated_outlet.max_customers]
		net_worth.text = GUI.money_string(associated_outlet.net_worth)
		if associated_outlet.get_parent() == gui.player_company:
			cost = associated_mall.rent
			buyout_button.text = "Sell (%s)" % GUI.money_string(cost)
			if associated_outlet.get_parent().outlets.size() == 1:
				buyout_button.disabled = true
				buyout_button.hint_tooltip = "You can't sell your last Outlet!"
			else:
				buyout_button.disabled = false
				buyout_button.hint_tooltip = "Sell Lot %s of %s for %s. Your Outlet will be closed." % [String(lot_id), associated_mall.name, GUI.money_string(cost)]
		else:
			cost = associated_outlet.net_worth
			buyout_button.text = "Buyout (%s)" % GUI.money_string(cost)
			if associated_outlet.get_parent().outlets.size() == 1 && associated_outlet.get_parent().cash >= 0:
				buyout_button.disabled = true
				buyout_button.hint_tooltip = "A Company will not sell its last Outlet unless it is in debt."
			else:
				buyout_button.disabled = cost > gui.player_company.cash
				if buyout_button.disabled:
					buyout_button.hint_tooltip = "You don't have enough Cash to Buyout this Outlet."
				else:
					buyout_button.hint_tooltip = "Buyout Lot %s of %s from %s for %s." % [String(lot_id), associated_mall.name, associated_outlet.get_parent().name, GUI.money_string(cost)]
		occupied_text.show()
		unoccupied_text.hide()

func _on_BuyLotButton_pressed():
	emit_signal("BuyLotButton_pressed", self)

func _on_BuyoutButton_pressed():
	emit_signal("BuyoutButton_pressed", self)

func _on_Owner_Name_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == BUTTON_LEFT:
			emit_signal("OwnerName_pressed", self)