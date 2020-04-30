extends Node

"Icon made by Freepik from www.flaticon.com"
class_name EventManager, "res://icons/EventManager.svg"

enum EVENT{
    GAME_START,
    ENEMIES_PRELOADED,
    ENEMIES_LOADED, 
    ITEMS_LOADED,
    PLAYER_READY,
    PLAYER_DEAD
}
signal updated
var _event_queue: Array = [EVENT.GAME_START] 


func _process(_delta):
    if _event_queue: 
        var top = _event_queue.pop_front()
        emit_signal("updated", top)

func push(event:int):
    _event_queue.push_back(event)
