class_name Symbol
extends Area2D

signal player_picked_symbol(symbol)

enum Type {DASH, DOT}

const PickSymbolSplash = preload("res://effects/pick_symbol_splash.tscn")


var type: int


func _ready():
	randomize_hover_animation()

func randomize_hover_animation() -> void:
	$AnimationPlayer.seek(
		Random.get_float(0, $AnimationPlayer.current_animation_length),
		true)


func set_symbol_type(symbol_type: int) -> void:
	type = symbol_type
	$Sprite.frame = 0 if symbol_type == Type.DOT else 1


func _on_symbol_area_entered(_area: Area2D) -> void:
	emit_signal("player_picked_symbol", self)
	$AnimationPlayer.stop()
	$AnimationPlayer.play("disappear")

func emit_splash() -> void:
	var splash = PickSymbolSplash.instance()
	add_child(splash)
