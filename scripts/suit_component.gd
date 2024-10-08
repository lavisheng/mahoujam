class_name SuitComponent extends Node


func ActivatePower(player: Player, suit: SuitData) -> void:
	suit.SuitAbilityCallback(player)


func ProcessPower(player: Player, suit: SuitData, delta: float) -> void:
	suit.SuitAbilityProcess(player, delta)


func CollideSuit(player: Player, suit: SuitData) -> void:
	suit.SuitCollisionCallback(player)


func HitSuitBody(player: Player, suit: SuitData, damage: int) -> void:
	suit.SuitHitBodyCallback(player, damage)


func HitSuitLeg(player: Player, suit: SuitData, damage: int) -> void:
	suit.SuitHitLegCallback(player, damage)


func ProcessSuitSwap(
	body: Player, primarySuit: SuitData, secondarySuit: SuitData, inputPressed: bool
) -> void:
	if inputPressed:
		body.active_suit = secondarySuit
		body.inactive_suit = primarySuit
		body.modulate = primarySuit.suitColor
