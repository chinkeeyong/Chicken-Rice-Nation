extends Node

export var subtitle = "No Subtitle"
export(Texture) var logo

export var is_player_controlled = false

export var brand_strength = 0.0

export var net_worth = 0.0

export var cash = 0.0

export var suspicion = 0.0
const SUSPICION_QUARTERLY_TICK_AMOUNT = -1.0
var suspicion_quarterly_tick_factor = 1.0

var income = 0.0
var income_sales = 0.0
var income_other = 0.0
var income_factor = 1.0

var expenditure = 0.0
var expenditure_rental = 0.0
var expenditure_other = 0.0
var expenditure_factor = 1.0

var balance = 0.0
var growth = 0.0

var outlets = [] # Should be of type Outlet
var modifiers = [] # Should be of type Modifier


func _ready():
	calc_net_worth()
	pass


func quarterly_tick():
	
	calc_balance()
	cash += balance
	
	suspicion -= SUSPICION_QUARTERLY_TICK_AMOUNT * suspicion_quarterly_tick_factor


func calc_balance():
	
	income = income_sales
	income += income_other
	
	expenditure = expenditure_rental
	expenditure += expenditure_other
	
	balance = income - expenditure


func calc_net_worth():
	
	net_worth = cash