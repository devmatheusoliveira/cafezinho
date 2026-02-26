extends Node

var main_scene: PackedScene = preload("res://levels/Cidade_Medieval.tscn")

var previous_scene

var itensDropados = 0
# Informações do Jogador

var max_hp = 1000
var current_life = 1000
var strength = 600
var defense = 8
var agility = 10
var level = 1
var exp = 0
var exp_total = 11

func get_exp():
	return exp

func get_exp_total():
	return exp_total

func get_hp():
	return current_life

func get_hp_total():
	return max_hp

func get_strength():
	return strength

func get_defense():
	return defense

func get_agility():
	return agility

func reset_all():
	max_hp = 1000
	current_life = 1000
	strength = 600
	defense = 10
	agility = 10
	level = 1
	exp = 0
	exp_total = 11
	pass
