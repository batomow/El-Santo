extends Node

class_name EventConsumer

func _ready():
    var err = EventManager.connect("updated", get_parent(), "consume_event")
    if err: 
        printerr("Coudl't subscribe to event manager: {0}" % self.name)
