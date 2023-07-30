extends PanelContainer

@onready var progress_bars = {
	Fighter.TYPE.PLAYER: %PlayerHP,
	Fighter.TYPE.ENEMY: %EnemyHP,
}


func set_hp(actor: Fighter.TYPE, current_hp, max_hp):
	var path = progress_bars[actor]
	path.max_value = max_hp
	path.value = current_hp
	path.get_node("Label").text = "HP: %d/%d" % [current_hp, max_hp]
