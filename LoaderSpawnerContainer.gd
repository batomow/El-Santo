extends Position2D

class_name LSC

enum TYPE {LOADER, SPAWNER, CONTAINER}
export (TYPE) var type

enum TAG {ENEMY, ITEM}
export (TAG) var tag

export (NodePath) var spawns_container_path: String 
export (PackedScene) var scene: PackedScene
signal loaded

func _ready():
    if type == TYPE.CONTAINER: 
        self.position = Vector2(0,0) # reset position 

func spawn()->void: 
    var spawns_container:LSC = get_node(spawns_container_path)
    var spawns:Array = spawns_container.get_children()
    for spawn in spawns: 
        if (spawn as LSC).tag == tag: 
            _load_scene(spawn.position)
    emit_signal("loaded")

func _load_scene(position: Vector2)->void: 
    var new_instance = scene.instance() as Node2D
    self.add_child(new_instance)
    new_instance.position = position
