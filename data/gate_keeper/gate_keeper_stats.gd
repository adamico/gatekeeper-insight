## GateKeeperStats.gd
# This script defines a resource that manages the gatekeeper's known visitor profiles.
# It allows adding profiles and checking if a profile is known.
# It is used by the GateKeeper to manage visitor profiles efficiently.
class_name GateKeeperStats extends Resource

@export var known_profiles: Array[String] = []
@export var senses_focus_ranks: Dictionary = {
    "psychic": 0,
    "smell": 0,
    "hearing": 0,
    "thermal": 0,
    "tactile": 0,
}

var _max_focus_rank:= 3


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


func get_focus_rank(sense_id: String) -> int:
    return senses_focus_ranks[sense_id] if senses_focus_ranks.has(sense_id) else 0


func update_focus_rank(sense_id: String) -> void:
    print ("[GateKeeperStats]Try increasing focus rank for sense '%s' from %2.1f to %2.1f"\
        % [sense_id, senses_focus_ranks[sense_id], senses_focus_ranks[sense_id] + 1])
    
    # ensure the sense name is valid
    if not senses_focus_ranks.keys().has(sense_id):
        print("[GateKeeperStats]Invalid sense name: '%s'" % sense_id)
        return

    # ensure the focus rank is not already at the maximum
    if senses_focus_ranks[sense_id] >= _max_focus_rank:
        print("[GateKeeperStats]Focus rank for sense '%s' is already at maximum (%2.1f)" % [sense_id, _max_focus_rank])
        return
    
    # increase the focus rank for the sense
    senses_focus_ranks[sense_id] += 1

    print("[GateKeeperStats]Focus rank for sense '%s' increased to %2.1f" % [sense_id, senses_focus_ranks[sense_id]])


func create_instance() -> Resource:
    var instance: GateKeeperStats = self.duplicate()
    return instance