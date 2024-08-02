extends Control
@onready var coin_counter = $container/coin_container/coin_counter as Label
@onready var timer_counter = $container/timer_container/timer_counter as Label
@onready var life_counter = $container/vidas_container/life_counter as Label
@onready var clock_timer = $container/clock_timer as Timer

var minutes = 0 
var segunds = 0 
@export_range(0,5) var default_minutes := 1
@export_range(0,59) var desfault_segunds := 0

signal time_is_up()


# Called when the node enters the scene tree for the first time.
func _ready():
	coin_counter.text = str("%04d" % Globals.coins)
	life_counter.text = str("%02d" % Globals.player_life)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	coin_counter.text = str("%04d" % Globals.coins)
	life_counter.text = str("%02d" % Globals.player_life)
	




	
