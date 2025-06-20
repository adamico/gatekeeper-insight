extends Node
## EventBus
# This class serves as a global event bus for the game, allowing different parts of the game
# to communicate with each other through events.

# Senses-related events
signal sense_used(sense_name: String)

func _ready() -> void:
    # Initialize the event bus if needed
    sense_used.connect(_on_sense_used)


func _on_sense_used(sense_name: String) -> void:
    # Handle the sense used event
    print("[EventBus]Sense used: %s" % sense_name)
    # Here you can add additional logic to handle the sense being used,
    # such as updating UI, triggering animations, etc.
