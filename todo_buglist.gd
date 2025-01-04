# BUG

# TODO
## Exit Button
## Main Menu Build Notes. Click to expand to full screen.
## Tame animal, have them follow you, help you in some way. (Fun examples: Smallands, Valheim)
## COUNT MONEY ANIMATION (RETHINK INVENTORY, NO ICONS ALL DIAGETIC) 

# INFO Build 10
"""
Dialogue System. You may now talk to the signs.
New UI.
Support for 16:9, 16:10, 21:9 and 4:3 aspect ratioes.
New build for Web Browsers.
Added hotkeys for Pause Menu
"""
# INFO Bugs Fixed
## Player movement halts when passing an interaction zone. Probably related to input_handling.(EDIT: It's related to player collision. SOLUTION: Changing the Motion Mode  of player(CharacterBody2D) from Grounded to Float. I guess Float is better for top-down 2D
## Player Interaction Area is also behind the player. SOLUTION: Separate Area on Player. One for door. One for interaction. Used Layers and masks so for detection.
