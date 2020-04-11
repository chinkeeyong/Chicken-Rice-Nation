extends Node

export var subtitle = "No Subtitle"
export(Texture) var logo

export var brand_strength = 1.0
export var seed_count = 1
export var minimum_seed_prestige = 0.0
export var maximum_seed_prestige = 50.0
export var seed_multiple_outlets = false

var net_worth = 0.0
var prev_net_worth = 0.0

export var cash = 0.0 setget set_cash
signal cash_changed

export var suspicion = 0.0 setget set_suspicion
signal suspicion_changed
const SUSPICION_QUARTERLY_TICK_AMOUNT = -1.0
var suspicion_quarterly_tick_factor = 1.0

var income = 0.0
var income_sales = 0.0
var income_liquidation = 0.0
var income_other = 0.0
var income_factor = 1.0

var expenditure = 0.0
var expenditure_rental = 0.0
var expenditure_acquisition = 0.0
var expenditure_other = 0.0
var expenditure_factor = 1.0

var balance = 0.0

var growth = 0.0
var quarters_without_growth = 0

var outlets = [] # Should be of type Outlet
var modifiers = [] # Should be of type Modifier


func quarterly_tick():
	
	calc_balance()
	cash += balance
	if growth <= 0:
		quarters_without_growth += 1
	else:
		quarters_without_growth = 0
	
	suspicion -= SUSPICION_QUARTERLY_TICK_AMOUNT * suspicion_quarterly_tick_factor
	if suspicion < 0:
		suspicion = 0
	emit_signal("cash_changed")
	emit_signal("suspicion_changed")


func calc_balance():
	
	income = income_sales
	income += income_liquidation
	income += income_other
	
	expenditure = expenditure_rental
	expenditure += expenditure_acquisition
	expenditure += expenditure_other
	
	balance = income + expenditure
	
	if prev_net_worth == 0:
		growth = 0.0
	else:
		growth = (net_worth / prev_net_worth) - 1


func calc_net_worth():
	net_worth = cash
	for outlet in outlets:
		outlet.calc_net_worth()
		net_worth += outlet.net_worth


func create_outlet(mall: Mall, empty_lot_id: int):
	empty_lot_id -= 1 # This is because Lot IDs start from 1
	if mall.lots[empty_lot_id] == null && empty_lot_id >= 0 && empty_lot_id < mall.lots.size():
		var new_outlet = Outlet.new()
		add_child(new_outlet, true)
		outlets.push_back(new_outlet)
		new_outlet.add_to_group("outlets")
		new_outlet.location = mall
		new_outlet.lot_id = empty_lot_id
		mall.lots[empty_lot_id] = new_outlet
		calc_net_worth()
		# print("Created an outlet for %s at slot %s of %s." % [name, String(empty_lot_id), mall.name])
	else:
		print("Tried to create an outlet for %s at slot %s of %s but the slot was already taken." % [name, String(empty_lot_id), mall.name])

func set_cash(new_value):
	cash = new_value
	emit_signal("cash_changed")
	
func set_suspicion(new_value):
	suspicion = new_value
	emit_signal("suspicion_changed")