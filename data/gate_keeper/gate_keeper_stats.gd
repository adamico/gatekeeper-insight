## GateKeeperStats.gd
# This script defines a resource that manages the gatekeeper's known visitor profiles.
# It allows adding profiles and checking if a profile is known.
# It is used by the GateKeeper to manage visitor profiles efficiently.
class_name GateKeeperStats
extends Resource

@export var known_profiles: Array[String] = []


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
