package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import flixel.addons.display.FlxBackdrop;
import Controls;

using StringTools;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Notes', 'Controls' #if android, 'Android Controls' #end, 'Preferences'];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	
	var wall:FlxBackdrop;
	var banner:FlxBackdrop;

	override function create() {
		FlxG.mouse.visible = false;

		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		menuBG = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = ClientPrefs.globalAntialiasing;
		add(menuBG);

		wall = new FlxBackdrop(Paths.image('Vents_and_Wires'), 1, 5, true, true);
		wall.setPosition(0, 750);
		wall.updateHitbox();
		wall.antialiasing = ClientPrefs.globalAntialiasing;
		add(wall);

		banner = new FlxBackdrop(Paths.image('Banner'), 1, 5, true, true);
		banner.setPosition(0, 750);
		banner.updateHitbox();
		banner.antialiasing = ClientPrefs.globalAntialiasing;
		add(banner);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true, false);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}
		changeSelection();

                #if android
	        addVirtualPad(UP_DOWN, A_B);
                #end

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
		changeSelection();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		wall.y = FlxMath.lerp(wall.y, wall.y + 10, CoolUtil.boundTo(elapsed * 9, 0, 1));
		banner.y = FlxMath.lerp(banner.y, banner.y + 20, CoolUtil.boundTo(elapsed * 9, 0, 1));

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if(FlxG.save.data.weekCompleted != null)
				MusicBeatState.switchState(new AftonMenuState());
			else
				MusicBeatState.switchState(new MainMenuState());
		}

		if (controls.ACCEPT) {
			for (item in grpOptions.members) {
				item.alpha = 0;
			}
			
			#if android
			removeVirtualPad();
			#end

			switch(options[curSelected]) {
				case 'Notes':
					openSubState(new options.NotesSubstate());

				case 'Controls':
					openSubState(new options.ControlsSubstate());

				case 'Android Controls':
					MusicBeatState.switchState(new android.AndroidControlsMenu());

				case 'Preferences':
					openSubState(new options.PreferencesSubstate());
			}
		}
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;

		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
			}
		}
	}
}