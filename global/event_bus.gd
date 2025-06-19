extends Node
## EventBus
# This class serves as a global event bus for the game, allowing different parts of the game
# to communicate with each other through events.

# Senses-related events
signal sense_used(sense: Sense)
