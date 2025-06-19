## Visitor.gd
# This script defines a Visitor resource that represents a visitor to the city.
# It includes properties such as id, true_name, profile, and history.
# It also includes senses focus values and their corresponding text descriptions.
# The Visitor can generate a random name, select a random body texture, and generate a history
class_name Visitor
extends Resource

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

@export var id: String
@export var true_name: String
@export var profile: Profile
@export_multiline var history: String

# Senses focus values
# These values represent the focus ranks needed for each sense to gather information.
@export_category("Senses focus ranks and information obtained")
@export var smell_details: Dictionary[int, String] = {
    0: "",
    1: "",
    2: "",
    3: "",
    4: "",
}
@export var psychic_details: Dictionary[int, String] = {
    0: "",
    1: "",
    2: "",
    3: "",
    4: "",
}
@export var hearing_details: Dictionary[int, String] = {
    0: "",
    1: "",
    2: "",
    3: "",
    4: "",
}
@export var thermal_details: Dictionary[int, String] = {
    0: "",
    1: "",
    2: "",
    3: "",
    4: "",
}
@export var tactile_details: Dictionary[int, String] = {
    0: "",
    1: "",
    2: "",
    3: "",
    4: "",
}

@export var smell_focus: float = 0.0
@export var smell_text: String
@export var psychic_focus: float = 0.0
@export var psychic_text: String
@export var hearing_focus: float = 0.0
@export var hearing_text: String
@export var thermal_focus: float = 0.0
@export var thermal_text: String
@export var tactile_focus: float = 0.0
@export var tactile_text: String

var name: String
var profile_name: String : set = _set_profile_name
var texture: Texture2D


func _init() -> void:
    # generate a random name
    name = "Visitor_" + str(randi() % 1000)
    # randomly select a body texture
    texture = BODIES.pick_random()
    _generate_history()


func _set_profile_name(value: String) -> void:
    profile_name = value
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
            profile_name = "?Unknown?"


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
