extends Resource
class_name MinigameData

@export var minigame_type: Minigame.TYPE
@export_group("Cutscene", "c")
@export var c_is_mad: bool = false
@export var c_animation_name: String = ""
@export var c_dialoge_res: DialogueResource
@export var c_enemy_res: PlanetResource = null
@export_group("Travel", "t")
@export var t_minigame_time: int = 10
@export var t_sec_every_nonliving_spawn: float = 1
@export var t_additional_nonliving_speed: int = 0
@export_group("Fight", "f")
@export var f_enemy_res: PlanetResource = null
