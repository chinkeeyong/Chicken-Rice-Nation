extends Node

class_name Outlet

# This object is the child of a Company and referenced by a Mall
var customers = 0
var max_customers = 10
var net_worth = 0.0
var lot_id = 0
var location

func calc_net_worth():
	net_worth = 0.0
	var rent_factor = location.rent * 2
	net_worth += rent_factor
	var parent_brand_factor = get_parent().brand_strength * 2000
	net_worth += parent_brand_factor

func destroy():
	while location.lots.find(self) != -1:
		location.lots[location.lots.find(self)] = null
	get_parent().outlets.erase(self)
	get_parent().calc_net_worth()
	queue_free()