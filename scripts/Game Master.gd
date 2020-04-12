extends Node

class_name GameMaster

export(NodePath) var gui_path
var gui
export(NodePath) var companies_path
var companies
export(NodePath) var malls_path
var malls
export(NodePath) var player_company_path
var player_company


const CUSTOMER_BRAND_STRENGTH_WEIGHT = 0.01


export var month = 1
export var year = 2020


func _ready():
	gui = get_node(gui_path)
	gui.connect("Next_Month_Button_pressed", self, "next_month")
	
	companies = get_node(companies_path).get_children()
	malls = get_node(malls_path).get_children()
	player_company = get_node(player_company_path)
	
	seed_company_outlets()
	
	for company in companies:
		company.calc_net_worth()
		company.prev_net_worth = company.net_worth
	
	next_month()


func seed_company_outlets():
	# All companies should have at least one outlet somewhere.
	# Take the highest prestige mall that the company can afford
	for company in companies:
		seed_outlet(company)
	# Now that all companies have one outlet, seed extra outlets
	for company in companies:
		var temp_seed_count = company.seed_count
		while temp_seed_count > 1:
			seed_outlet(company)
			temp_seed_count -= 1
	

func seed_outlet(company):
	randomize()
	malls.shuffle()
	var best_mall = null
	for lot_scanned in range(6): # Prioritize empty malls first before working our way up
		for mall in malls:
			
			# Don't have multiple outlets in the same mall unless seed multiple is on
			if !company.seed_multiple_outlets:
				var has_duplicate_outlet_in_this_mall = false
				for outlet in mall.lots:
					if outlet != null:
						if outlet.get_parent() == company:
							has_duplicate_outlet_in_this_mall = true
							break
				if has_duplicate_outlet_in_this_mall:
					continue
			
			# Create a mall if this scanned lot is empty
			if mall.lots[lot_scanned] == null:
				if mall.prestige <= company.maximum_seed_prestige && mall.prestige >= company.minimum_seed_prestige:
						best_mall = mall
						break
		
		if best_mall != null:
			company.create_outlet(best_mall, lot_scanned + 1)
			break
	if best_mall == null:
		print("Couldn't create a mall for %s" % company.name)


func next_month():
	
	month += 1
	if month > 12:
		month = 1
		year += 1
	
	# Assign customers
	for mall in malls:
		for outlet in mall.lots:
			if outlet != null:
				outlet.customers = 0
		var unassigned_customers = mall.customers
		
		while unassigned_customers > 0:
			unassigned_customers -= 1
			
			var outlet_weights = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
			var sum_of_weights = 0.0
			for i in range(outlet_weights.size()):
				if mall.lots[i] != null && mall.lots[i].customers < mall.lots[i].max_customers:
					outlet_weights[i] += 1
					outlet_weights[i] += mall.lots[i].get_parent().brand_strength * CUSTOMER_BRAND_STRENGTH_WEIGHT
					if mall.lots[i].get_parent().brand_strength < mall.prestige:
						outlet_weights[i] /= 2
				sum_of_weights += outlet_weights[i]
			
			var random_choice = rand_range(0.0, sum_of_weights)
			for i in range(outlet_weights.size()):
				if random_choice < outlet_weights[i]:
					# Chose this outlet
					mall.lots[i].customers += 1
					break
				else:
					random_choice -= outlet_weights[i]
	
	for company in companies:
		company.monthly_tick()
	
	gui.update_f1()
	gui.update_mall_viewer()
	gui.update_date_stamp(month, year)