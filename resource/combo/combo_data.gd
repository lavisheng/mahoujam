class_name ComboData extends Resource

# string output to player on UI.
@export var comboIdentifier: String;
# Check current combo, if the combo is higher than this value, then run this combo.
@export var comboFloor: int;
# Animation to play on combo when entering this combo 
@export var comboIntroAnim: Texture2D;
# Looping animation to play while in this combo.
@export var comboLoopingAnim: Texture2D;
#Color of combo text
@export var comboColour: Color;