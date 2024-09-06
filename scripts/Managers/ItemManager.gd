extends Node

var numCollectables = 0;
var maxNumCollectables = 10;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.Subscribe( "CollectPickup", self, "AddCollectable" );
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func AddCollectable( numToAdd: int ):
	numCollectables = numCollectables + numToAdd;
	print( "ItemManager got a new item! Its lit!" );
	pass;