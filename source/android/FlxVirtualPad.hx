package android;

import android.FlxButton;
import flixel.FlxG;
import flixel.graphics.frames.FlxTileFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxDestroyUtil;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import openfl.utils.Assets;

/**
 * A gamepad.
 * It's easy to customize the layout.
 *
 * @original author Ka Wing Chin
 * @modification's author: Saw (M.A. Jigsaw)
 */
class FlxVirtualPad extends FlxSpriteGroup
{
	public var buttonLeft:FlxButton = new FlxButton(0, 0);
	public var buttonUp:FlxButton = new FlxButton(0, 0);
	public var buttonRight:FlxButton = new FlxButton(0, 0);
	public var buttonDown:FlxButton = new FlxButton(0, 0);

	public var buttonLeft2:FlxButton = new FlxButton(0, 0);
	public var buttonUp2:FlxButton = new FlxButton(0, 0);
	public var buttonRight2:FlxButton = new FlxButton(0, 0);
	public var buttonDown2:FlxButton = new FlxButton(0, 0);

	public var buttonA:FlxButton = new FlxButton(0, 0);
	public var buttonB:FlxButton = new FlxButton(0, 0);
	public var buttonC:FlxButton = new FlxButton(0, 0);
	public var buttonD:FlxButton = new FlxButton(0, 0);
	public var buttonE:FlxButton = new FlxButton(0, 0);
	public var buttonV:FlxButton = new FlxButton(0, 0);
	public var buttonX:FlxButton = new FlxButton(0, 0);
	public var buttonY:FlxButton = new FlxButton(0, 0);
	public var buttonZ:FlxButton = new FlxButton(0, 0);

	/**
	 * Create a gamepad.
	 *
	 * @param   DPadMode     The D-Pad mode. `FULL` for example.
	 * @param   ActionMode   The action buttons mode. `A_B_C` for example.
	 */
	public function new(DPad:FlxDPadMode, Action:FlxActionMode)
	{
		super();

		scrollFactor.set();

		switch (DPad)
		{
			case UP_DOWN:
				add(buttonUp = createButton(0, FlxG.height - 255, 132, 127, 'up'));
				add(buttonDown = createButton(0, FlxG.height - 135, 132, 127, 'down'));
			case LEFT_RIGHT:
				add(buttonLeft = createButton(0, FlxG.height - 135, 132, 127, 'left'));
				add(buttonRight = createButton(127, FlxG.height - 135, 132, 127, 'right'));
			case UP_LEFT_RIGHT:
				add(buttonUp = createButton(105, FlxG.height - 243, 132, 127, 'up'));
				add(buttonLeft = createButton(0, FlxG.height - 135, 132, 127, 'left'));
				add(buttonRight = createButton(207, FlxG.height - 135, 132, 127, 'right'));
			case FULL:
				add(buttonUp = createButton(105, FlxG.height - 345, 132, 127, 'up'));
				add(buttonLeft = createButton(0, FlxG.height - 243, 132, 127, 'left'));
				add(buttonRight = createButton(207, FlxG.height - 243, 132, 127, 'right'));
				add(buttonDown = createButton(105, FlxG.height - 135, 132, 127, 'down'));
			case RIGHT_FULL:
				add(buttonUp = createButton(FlxG.width - 258, FlxG.height - 408, 132, 127, 'up'));
				add(buttonLeft = createButton(FlxG.width - 384, FlxG.height - 309, 132, 127, 'left'));
				add(buttonRight = createButton(FlxG.width - 132, FlxG.height - 309, 132, 127, 'right'));
				add(buttonDown = createButton(FlxG.width - 258, FlxG.height - 201, 132, 127, 'down'));
			case DUO:
				add(buttonUp = createButton(105, FlxG.height - 345, 132, 127, 'up'));
				add(buttonLeft = createButton(0, FlxG.height - 243, 132, 127, 'left'));
				add(buttonRight = createButton(207, FlxG.height - 243, 132, 127, 'right'));
				add(buttonDown = createButton(105, FlxG.height - 135, 132, 127, 'down'));
				add(buttonUp2 = createButton(FlxG.width - 258, FlxG.height - 408, 132, 127, 'up'));
				add(buttonLeft2 = createButton(FlxG.width - 384, FlxG.height - 309, 132, 127, 'left'));
				add(buttonRight2 = createButton(FlxG.width - 132, FlxG.height - 309, 132, 127, 'right'));
				add(buttonDown2 = createButton(FlxG.width - 258, FlxG.height - 201, 132, 127, 'down'));
			case NONE: // do nothing
		}

		switch (Action)
		{
			case A:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a'));
			case B:
				add(buttonB = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'b'));
			case D:
				add(buttonD = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'd'));						
			case A_B:
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b'));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a'));
			case A_B_C:
				add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b'));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a'));
			case A_B_E:
				add(buttonE = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'e'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b'));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a'));
			case A_B_X_Y:
				add(buttonX = createButton(FlxG.width - 510, FlxG.height - 135, 132, 127, 'x'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b'));

				add(buttonY = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'y'));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a'));
			case A_B_C_X_Y:
				add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c'));
				add(buttonX = createButton(FlxG.width - 258, FlxG.height - 255, 132, 127, 'x'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b'));
				add(buttonY = createButton(FlxG.width - 132, FlxG.height - 255, 132, 127, 'y'));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a'));
			case A_B_C_X_Y_Z:
				add(buttonX = createButton(FlxG.width - 384, FlxG.height - 255, 132, 127, 'x'));
				add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c'));
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 255, 132, 127, 'y'));

				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b'));
				add(buttonZ = createButton(FlxG.width - 132, FlxG.height - 255, 132, 127, 'z'));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a'));
			case FULL:
				add(buttonV = createButton(FlxG.width - 510, FlxG.height - 255, 132, 127, 'v'));
				add(buttonD = createButton(FlxG.width - 510, FlxG.height - 135, 132, 127, 'd'));
				add(buttonX = createButton(FlxG.width - 384, FlxG.height - 255, 132, 127, 'x'));
				add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c'));
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 255, 132, 127, 'y'));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b'));
				add(buttonZ = createButton(FlxG.width - 132, FlxG.height - 255, 132, 127, 'z'));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a'));
			case NONE: // do nothing
		}
	}

	public function createButton(X:Float, Y:Float, Width:Int, Height:Int, Graphic:String):FlxButton
	{
		var button:FlxButton = new FlxButton(X, Y);
		var frames = getVirtualInputFrames().getByName(Graphic);
		button.frames = FlxTileFrames.fromFrame(frames, FlxPoint.get(Width, Height));
		button.resetSizeFromFrame();
		button.solid = false;
		button.immovable = true;
		button.scrollFactor.set();
		button.color = Color;

		#if FLX_DEBUG
		button.ignoreDrawDebug = true;
		#end

		return button;
	}

	public static function getVirtualInputFrames():FlxAtlasFrames
	{
		return Paths.getPackerAtlas('androidcontrols/virtualpad');
	}

	/**
	 * Clean up memory.
	 */
	override public function destroy():Void
	{
		super.destroy();

		buttonLeft = null;
		buttonUp = null;
		buttonDown = null;
		buttonRight = null;

		buttonLeft2 = null;
		buttonUp2 = null;
		buttonDown2 = null;
		buttonRight2 = null;

		buttonA = null;
		buttonB = null;
		buttonC = null;
		buttonD = null;
		buttonE = null;
		buttonV = null;
		buttonX = null;
		buttonY = null;
		buttonZ = null;
	}
}

enum FlxDPadMode
{
	UP_DOWN;
	LEFT_RIGHT;
	UP_LEFT_RIGHT;
	FULL;
	RIGHT_FULL;
	DUO;
	NONE;
}

enum FlxActionMode
{
	A;
	B;
	D;
	A_B;
	A_B_C;
	A_B_E;
	A_B_X_Y;
	A_B_C_X_Y;
	A_B_C_X_Y_Z;
	FULL;
	NONE;
}