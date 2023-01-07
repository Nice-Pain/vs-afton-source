package android;

import android.FlxButton;
import android.AndroidControls;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxDestroyUtil;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.group.FlxSpriteGroup;
import openfl.utils.Assets;

/**
 * A zone with 4 buttons (A hitbox).
 * It's easy to customize the layout.
 *
 * @author: Saw (M.A. Jigsaw)
 */
class FlxHitbox extends FlxSpriteGroup
{
	public var buttonLeft:FlxButton = new FlxButton(0, 0);
	public var buttonDown:FlxButton = new FlxButton(0, 0);
	public var buttonUp:FlxButton = new FlxButton(0, 0);
	public var buttonRight:FlxButton = new FlxButton(0, 0);

	var hitbox_hint:FlxSprite;

	/**
	 * Create the zone.
	 */
	public function new()
	{
		super();

		scrollFactor.set();

		add(buttonLeft = createHint(0, 0, 'left', 0xFF00FF));
		add(buttonDown = createHint(FlxG.width / 4, 0, 'down', 0x00FFFF));
		add(buttonUp = createHint(FlxG.width / 2, 0, 'up', 0x00FF00));
		add(buttonRight = createHint((FlxG.width / 2) + (FlxG.width / 4), 0, 'right', 0xFF0000));

		hitbox_hint = new FlxSprite(0, 0).loadGraphic(Paths.image('androidcontrols/hitbox_hint'));
		hitbox_hint.alpha = 0.75;
		add(hitbox_hint);
	}

	/**
	 * Clean up memory.
	 */
	override function destroy()
	{
		super.destroy();

		buttonLeft = null;
		buttonDown = null;
		buttonUp = null;
		buttonRight = null;
	}

        public static function getHitboxFrames():FlxAtlasFrames
	{
		return Paths.getSparrowAtlas('androidcontrols/hitbox');
	}

	private function createHint(X:Float, Y:Float, Frames:String, Color:Int = 0xFFFFFF):FlxButton
	{
                var hintTween:FlxTween = null;
		var hitboxframes = getHitboxFrames().getByName(Frames);
		var graphic:FlxGraphic = FlxGraphic.fromFrame(hitboxframes);
		var hint = new FlxButton(X, Y);
		hint.loadGraphic(graphic);
		hint.alpha = 0.00001;
		hint.setGraphicSize(Std.int(FlxG.width / 4), FlxG.height);
		hint.updateHitbox();
		hint.solid = false;
		hint.immovable = true;
		hint.scrollFactor.set();
		hint.color = Color;
		hint.onDown.callback = function()
		{
			if (hintTween != null)
				hintTween.cancel();

			hintTween = FlxTween.tween(hint, {alpha: AndroidControls.getOpacity()}, 0.001, {ease: FlxEase.circInOut, onComplete: function(twn:FlxTween)
			{
				hintTween = null;
			}});
		}
		hint.onUp.callback = function()
		{
			if (hintTween != null)
				hintTween.cancel();

			hintTween = FlxTween.tween(hint, {alpha: 0.00001}, 0.001, {ease: FlxEase.circInOut,	onComplete: function(twn:FlxTween)
			{
				hintTween = null;
			}});
		}
		hint.onOut.callback = function (){
			FlxTween.num(hint.alpha, 0, 0.2, {ease:FlxEase.circInOut}, function(alpha:Float){ 
				hint.alpha = alpha;
			});
		}
		#if FLX_DEBUG
		hint.ignoreDrawDebug = true;
		#end
		return hint;
	}
}
