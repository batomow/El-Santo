extends Node

"Icon made by Freepik from www.flaticon.com"
class_name State, "res://icons/State.svg"

var target: Object = null
var machine: State = null
var current: State = null
var next: State 
var states:Dictionary = {}
var substates: Array = [] 

export (int, "root", "machine", "state") var type = 2
export (bool) var reset_on_quit = 1
export (int) var default_node = 0
export (NodePath) var target_path = null

func _set_target(_target:Object, _machine:State = null):
	target = _target
	machine = _machine
	substates = get_children()
	if substates: 
		next = substates[default_node]
	for state in substates: 
		(state as State)._set_target(target, (self as State))
		states[state.name] = (state as State)

func _ready():
	if type == 0: # if root 
		_set_target(get_node(target_path))

func enter(): 
	pass

func execute(_delta): 
	if current: 
		current.execute(_delta)
	if current != next: 
		switch()

func evaluate(_delta): 
	if current: 
		current.evaluate(_delta)

func exit(): 
	if type == 1: 
		stop() 

func stop(): 
	if current:
		current.exit()
	current = null
	if reset_on_quit: 
		if substates: 
			next = substates[default_node]
	

func switch(): 
	if current: 
		current.exit()
	current = next
	if current: 
		current.enter()
