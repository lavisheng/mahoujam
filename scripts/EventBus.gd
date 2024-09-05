extends Node

class Event:
	var subscriber = null;
	var callback = null;
	var value = null;

var listeners = {};
var events = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ProcessEvents();
	pass

func ProcessEvents():
	for i in events.size():
		var event = events.pop_front();
		event.subscriber.call( event.callback, event.value );


func Subscribe( eventName, listener, method ):
	if !listener.has_method( method ):
		return;

	if !listeners.has( eventName ):
		listeners[eventName] = {};

	listeners[eventName][listener] = method;


func SendEvent( event_name, value = null ):
	var currentListeners = listeners[event_name];

	for listener in currentListeners.keys():
		var newEvent = Event.new();
		newEvent.subscriber = listener;
		newEvent.callback = currentListeners[listener];
		newEvent.value = value;

		events.push_back( newEvent );