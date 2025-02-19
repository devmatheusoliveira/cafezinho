extends Node

var main_scene: PackedScene = preload("res://levels/Cidade_Medieval.tscn")

var previous_scene


# Informações do Jogador

var max_hp = 600
var current_life = 600
var strength = 600
var level = 1
var defense
var exp = 0
var exp_total = 11

func get_exp():
	return exp

func get_exp_total():
	return exp_total
