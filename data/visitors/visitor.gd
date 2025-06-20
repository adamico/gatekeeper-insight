## Visitor.gd
# This script defines a Visitor resource that represents a visitor to the city.
# It includes properties such as id, true_name, profile, and history.
# It also includes senses focus values and their corresponding text descriptions.
# The Visitor can generate a random name, select a random body texture, and generate a history
class_name Visitor extends Resource

const BODY1: Texture2D = preload("res://assets/graphics/body1.png")
const BODY2: Texture2D = preload("res://assets/graphics/body2.png")
const BODY3: Texture2D = preload("res://assets/graphics/body3.png")
const BODY4: Texture2D = preload("res://assets/graphics/body4.png")
const BODY5: Texture2D = preload("res://assets/graphics/body5.png")
const BODY6: Texture2D = preload("res://assets/graphics/body6.png")
const BODY7: Texture2D = preload("res://assets/graphics/body7.png")
const BODY8: Texture2D = preload("res://assets/graphics/body8.png")
const BODIES: Array = [
    BODY1,
    BODY2,
    BODY3,
    BODY4,
    BODY5,
    BODY6,
    BODY7,
    BODY8
]

enum Profile {
    ANGEL,
    ASSASSIN,
    CITIZEN,
    CONSTRUCT,
    CULTIST,
    DEMON,
    FARMER,
    GUARD,
    MERCHANT,
    NOBLE,
    SHIFTER,
    SMUGGLER,
    SPY,
    TOURIST,
    TRAVELING_MERCHANT,
    VAGRANT,
    VAMPIRE,
    WEREWOLF,
    WITCH,
}

enum ProfileType {
    SAFE,
    DANGEROUS,
    UNKNOWN,
}


@export var id: String
@export var true_names: Array[String]
@export var profile: Profile
@export_multiline var history: String

# Senses focus values
# These values represent the focus ranks needed for each sense to gather information.
@export_category("Senses focus ranks and information obtained")
@export var psyche : Array[String]
@export var scent : Array[String]
@export var sound : Array[String]
@export var temperature : Array[String]
@export var tactile : Array[String]

var name: String
var texture: Texture2D


func _init() -> void:
    # generate a random name
    name = "Visitor_" + str(randi() % 1000)
    # randomly select a body texture
    texture = BODIES.pick_random()
    _generate_history()


func get_stats() -> Dictionary[String, Array]:
    # Return a dictionary of stats for the visitor
    return {
        "psychic": psyche,
        "smell": scent,
        "hearing": sound,
        "thermal": temperature,
        "tactile": tactile
    }


func get_true_name() -> String:
    return true_names.pick_random()


func get_profile_type() -> ProfileType:
    var profile_type: ProfileType
    match profile:
        Profile.ANGEL, Profile.CITIZEN, Profile.TOURIST, Profile.TRAVELING_MERCHANT,\
        Profile.NOBLE, Profile.FARMER, Profile.GUARD, Profile.MERCHANT:
            profile_type = ProfileType.SAFE
        Profile.ASSASSIN, Profile.CONSTRUCT, Profile.CULTIST, Profile.DEMON, Profile.SHIFTER,\
        Profile.SMUGGLER, Profile.SPY, Profile.VAGRANT, Profile.VAMPIRE, Profile.WEREWOLF, Profile.WITCH:
            profile_type = ProfileType.DANGEROUS
        _:
            profile_type = ProfileType.UNKNOWN
    return profile_type


func get_profile_name() -> String:
    var profile_name: String
    match profile:
        Profile.ANGEL:
            profile_name = "Angel"
        Profile.ASSASSIN:
            profile_name = "Assassin"
        Profile.CITIZEN:
            profile_name = "Citizen"
        Profile.CONSTRUCT:
            profile_name = "Construct"
        Profile.CULTIST:
            profile_name = "Cultist"
        Profile.DEMON:
            profile_name = "Demon"
        Profile.SHIFTER:
            profile_name = "Shifter"
        Profile.SMUGGLER:
            profile_name = "Smuggler"
        Profile.SPY:
            profile_name = "Spy"
        Profile.TOURIST:
            profile_name = "Tourist"
        Profile.TRAVELING_MERCHANT:
            profile_name = "Traveling Merchant"
        Profile.VAGRANT:
            profile_name = "Vagrant"
        Profile.VAMPIRE:
            profile_name = "Vampire"
        Profile.WEREWOLF:
            profile_name = "Werewolf"
        Profile.WITCH:
            profile_name = "Witch"
        _:
            profile_name = "???"
        
    return profile_name


func _generate_history() -> void:
    # Generate a random history based on the profile
    match profile:
        Profile.ANGEL:
            history = "An angelic being, sent to guide and protect the innocent."
        Profile.ASSASSIN:
            history = "A skilled assassin, trained in the art of stealth and deception."
        Profile.CITIZEN:
            history = "A regular citizen, living a simple life in the city."
        Profile.CONSTRUCT:
            history = "A mechanical construct, built to serve and protect."
        Profile.CULTIST:
            history = "A member of a dark cult, devoted to a sinister cause."
        Profile.DEMON:
            history = "A demon from the underworld, seeking to spread chaos and destruction."
        Profile.SHIFTER:
            history = "A shapeshifter, able to change their form at will."
        Profile.SMUGGLER:
            history = "A smuggler, skilled in the art of sneaking goods past authorities."
        Profile.SPY:
            history = "A spy, gathering information for a secret organization."
        Profile.TOURIST:
            history = "A tourist, exploring the wonders of the world."
        Profile.TRAVELING_MERCHANT:
            history = "A traveling merchant, trading goods and stories from distant lands."
        Profile.VAGRANT:
            history = "A vagrant, wandering the streets in search of shelter and food."
        Profile.VAMPIRE:
            history = "A vampire, cursed to roam the night in search of blood."
        Profile.WEREWOLF:
            history = "A werewolf, cursed to transform under the full moon."
        Profile.WITCH:
            history = "A witch, practicing dark magic and casting spells."
        _: "A mysterious visitor with an unknown past."
