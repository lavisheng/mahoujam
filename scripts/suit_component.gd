class_name SuitComponent extends Node


func ActivatePower(player: Player, suit: SuitData) -> void:
	suit.SuitAbilityCallback(player)


func ProcessPower(player: Player, suit: SuitData, delta: float) -> void:
	suit.SuitAbilityProcess(player, delta)


func ProcessSuitSwap(
	body: Player, primarySuit: SuitData, secondarySuit: SuitData, inputPressed: bool
) -> void:
	if inputPressed:
		body.active_suit = secondarySuit
		body.inactive_suit = primarySuit
		body.modulate = primarySuit.suitColor
