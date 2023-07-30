extends Resource
class_name MinigameData

@export var minigame_type: Minigame.TYPE
@export_group("Cutscene", "c")
@export var c_dialoge_res: DialogueResource
@export var c_enemy_res: PlanetResource = null
@export_group("Travel", "t")
@export_group("Fight", "f")
@export var f_enemy_res: PlanetResource = null
