class_name Suit_b extends SuitData

var hasBonusJump: bool = true
@export var bonusJumpVel: float = -250


func SuitAbilityCallback(_body: CharacterBody2D, _wantInput: bool):
    # print( "I'm an overloaded suit b" );
    # print( hasBonusJump );
    if _wantInput and hasBonusJump:
        _body.velocity.y = bonusJumpVel * jumpPowerMultiplier
        hasBonusJump = false

    if _body.is_on_floor() and not hasBonusJump:
        hasBonusJump = true
