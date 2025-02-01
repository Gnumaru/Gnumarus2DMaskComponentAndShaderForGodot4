# Description

This addon gives you both a shader and a script that makes it easy to create masks in 2D sprites in order to solve most of the simple scenarios involving masking sprites.

This used to be simple in godot 3 by using a light2d with mask mode, but in godot 4 things are different. If you have time, take a read at this proposal bellow:

https://github.com/godotengine/godot-proposals/issues/4282

# Usage

1) Inside the Sprite2D you want to mask, add a child Sprite2D node
1) Attach the Gnumarus2DMaskComponent.gd script to it
1) Move, rotate and scale the child sprite in any way you like.
1) Done!

BEWARE that skew is not implemented (PRs are welcome). Also the current implementation is very simple, so it is not possible to use several masks, only one per masked sprite.

If you still have any questions, take a look at the test scene at res://addons/Gnumarus2DMaskComponentAndShader/Test/Test.tscn