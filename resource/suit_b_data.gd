class_name Suit_b extends SuitData

var hasBonusJump: bool = true
@export var bonusJumpVel: float = -250

const NUM_AIRDASHES = 2
var num_airdashes: int = NUM_AIRDASHES
var airdash_delta: float = .75
var dash_speed: float = 2000
var jump_velocity: float = -350.0

var special_move: bool = false
var special_roll_delta: float = 1.


func SuitAbilityCallback(player: Player) -> void:
    # print( "I'm an overloaded suit b" );
    # print( hasBonusJump );
    if player.gravity_component.is_falling and player.input_component.get_special_input() and not air_movement:
        player.velocity = Vector2(1,1).limit_length(1.) * 1000
        air_movement = true
        special_move = true
        special_roll_delta = 2.
    #if player.input_component.get_special_input() and hasBonusJump:
    #    player.velocity.y = bonusJumpVel * j umpPowerMultiplier
    #    hasBonusJump = false

    #if player.is_on_floor() and not hasBonusJump:
    #    hasBonusJump = true

func handle_air_dash(player: Player, direction: float, delta: float) -> void:
    if not special_move and not player.is_on_floor() and direction != 0 and num_airdashes > 0:
        player.velocity.x = direction * dash_speed
        air_movement = true
        player.velocity.y = 0
        num_airdashes -= 1
        airdash_delta = .75
    elif air_movement and airdash_delta > 0:
        airdash_delta -= delta
        player.velocity.x *= airdash_delta * airdash_delta * airdash_delta
        if abs(player.velocity.x) <= 0.05:
            air_movement = false
func handle_double_jump(player: Player) -> void:
    if not player.movement_component.is_jumping and player.input_component.get_jump_input() and num_airdashes > 0:
        num_airdashes -= 1
        player.velocity.y = jump_velocity
        

func SuitAbilityProcess(player: Player, delta: float) -> void:
    if special_move and special_roll_delta > 0:
        if player.is_on_floor():
            special_roll_delta -= delta
            player.velocity.x = 400
            if player.input_component.get_jump_input():
                player.velocity.y = -600
                special_move = false
    else:
        handle_air_dash(player, player.input_component.input_doubletap, delta)
        handle_double_jump(player)
    if player.is_on_floor():
        num_airdashes = NUM_AIRDASHES
