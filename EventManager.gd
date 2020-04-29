extends Node

signal updated
var _event_queue: Array = [] 

enum EVENT{
    GAME_START,
    ENEMIES_LOADED, 
    ITEMS_LOADED,
    PLAYER_READY,
    PLAYER_DEAD
}

func _process(_delta):
    if _event_queue: 
        var top = _event_queue.front()
        emit_signal("updated", top)
        _event_queue.pop_front()

func _ready():
    push(EVENT.GAME_START)

func push(event:int):
    _event_queue.push_back(event)
