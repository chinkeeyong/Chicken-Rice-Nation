extends Node

class_name GameMaster

export(NodePath) var companies_path
var companies
export(NodePath) var malls_path
var malls
export(NodePath) var player_company_path
var player_company


func _ready():
	companies = get_node(companies_path).get_children()
	malls = get_node(malls_path).get_children()
	player_company = get_node(player_company_path)
	
	seed_company_outlets()
	
	for company in companies:
		company.calc_net_worth()
		company.prev_net_worth = company.net_worth


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
	for lot_scanned in range(5): # Prioritize empty malls first before working our way up
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