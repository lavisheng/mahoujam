class_name SuitComponent extends Node


func ActivatePower(body: CharacterBody2D, suit: SuitData, inputPressed: bool) -> void:
	suit.SuitAbilityCallback(body, inputPressed)


func ProcessPower(body: CharacterBody2D, suit: SuitData, inputPressed: bool, delta: float) -> void:
	suit.SuitAbilityProcess(body, inputPressed, delta)


func ProcessSuitSwap( body: Player, primarySuit: SuitData, secondarySuit: SuitData, inputPressed: bool ) -> void:
	if inputPressed:
		body.active_suit = secondarySuit;
		body.inactive_suit = primarySuit;
		body.modulate = primarySuit.suitColor;
