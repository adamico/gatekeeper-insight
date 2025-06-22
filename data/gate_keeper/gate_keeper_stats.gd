## GateKeeperStats.gd
# This script defines a resource that manages the gatekeeper's known visitor profiles.
# It allows adding profiles and checking if a profile is known.
# It is used by the GateKeeper to manage visitor profiles efficiently.
# It also manages the focus pool, which is used to track the gatekeeper's focus capacity.
# The focus pool decreases when the gatekeeper interacts with visitors and regenerates over time.
class_name GateKeeperStats extends Resource

@export var known_profiles: Array[String] = []
@export var max_focus_pool:= 15.0
@export var focus_pool_regen_rate:= 1.0

@export var senses_list: SensesList

var _current_focus_pool:= max_focus_pool

## Add a profile to the gate keeper's known profiles
## @param profile_name: The name of the profile to add
## If the profile is already known, it will not be added again
func add_visitor_profile(profile_name: String) -> void:
    if is_profile_known(profile_name):
        return
    
    known_profiles.append(profile_name)


## Check if a profile is known by the gate keeper
## @param profile_name: The name of the profile to check
## @return: True if the profile is known, False otherwise
func is_profile_known(profile_name: String) -> bool:
    return known_profiles.has(profile_name)


## Update the focus pool of the gate keeper
## This method is called to adjust the current focus pool based on the provided variation.
## @param variation: The amount to adjust the focus pool by
## It can be positive or negative, depending on the game logic.
func update_focus_pool(variation: float) -> void:
    print("[GateKeeperStats]Updating focus pool: current %2.1f, variation %2.1f" % [_current_focus_pool, variation])
    _current_focus_pool += variation
    _current_focus_pool = clamp(_current_focus_pool, 0.0, max_focus_pool)
    

## Create a new instance of GateKeeperStats
## This method duplicates the current instance and returns it.
## @return: A new instance of GateKeeperStats
## This is useful for creating a fresh state without affecting the original instance.
func create_instance() -> Resource:
    var instance: GateKeeperStats = self.duplicate(true)
    return instance