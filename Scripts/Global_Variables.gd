extends Node

var star_size = 1

var object_list_main = []
var object_outer_bound = star_size*40
var object_inner_bound = star_size*0.1
var object_frost_line = star_size*2.6

var object_mass_determiner = 0
var object_size_modifier = 0
var object_atmosphere_modifier = 0
var object_water_modifier = 0
var old_number = 0

var object_types = {
	1:"Rocky",
	2:"Icy",
	3:"Metallic",
	4:"Gas Giant",
	5:"Ice Giant"
}
var object_modifiers = {
	#General Modifications
	1:"Mini",
	2:"Small",
	3:"Average",
	4:"Large",
	5:"Huge"
}
var object_water_modifiers = {
	0:"Nonexistent",
	1:"Arid",
	2:"Lacustine",
	3:"Sub-Marine",
	4:"Marine",
	5:"Oceanic",
	6:"Hyper Oceanic"
}
var object_atmosphere_modifiers = {
	0:"Nonexistent",
	1:"Nonexistent",
	2:"Extremely Thin",
	3:"Thin",
	4:"Substantial",
	5:"Thick",
	6:"Extremely Thick",
	7:"Crushing"
}
