package;

#if android
import android.Tools;
import android.Permissions;
#end
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import openfl.Lib;
import haxe.CallStack.StackItem;
import haxe.CallStack;
import haxe.io.Path;
import sys.FileSystem;
class SUtil
{
    #if android
    private static var aDir:String = null;
    private static var sPath:String = AndroidTools.getExternalStorageDirectory();  
    private static var grantedPermsList:Array<Permissions> = AndroidTools.getGrantedPermissions();  
    #end

    public static function getPath():String #if android return Environment.getExternalStorageDirectory() + '/' + '.' + Lib.application.meta.get('file') +
		'/'; #else return ''; #end

    static public function doTheCheck()
    {
        #if android
	if (!Permissions.getGrantedPermissions().contains(Permissions.WRITE_EXTERNAL_STORAGE)
		&& !Permissions.getGrantedPermissions().contains(Permissions.READ_EXTERNAL_STORAGE))
	{
		if (VERSION.SDK_INT >= VERSION_CODES.M)
		{
			Permissions.requestPermissions([Permissions.WRITE_EXTERNAL_STORAGE, Permissions.READ_EXTERNAL_STORAGE]);

			/**
			 * Basically for now i can't force the app to stop while its requesting a android permission, so this makes the app to stop while its requesting the specific permission
			 */
			Lib.application.window.alert('If you accepted the permissions you are all good!' + "\nIf you didn't then expect a crash"
				+ '\nPress Ok to see what happens',
				'Permissions?');
		}
		else
		{
			Lib.application.window.alert('Please grant the game storage permissions in app settings' + '\nPress Ok to close the app', 'Permissions?');
			System.exit(1);
		}
	}

	if (Permissions.getGrantedPermissions().contains(Permissions.WRITE_EXTERNAL_STORAGE)
		&& Permissions.getGrantedPermissions().contains(Permissions.READ_EXTERNAL_STORAGE))
	{
		if (!FileSystem.exists(SUtil.getPath()))
			FileSystem.createDirectory(SUtil.getPath());

		if (!FileSystem.exists(SUtil.getPath() + 'assets') && !FileSystem.exists(SUtil.getPath() + 'mods'))
		{
			Lib.application.window.alert("Whoops, seems like you didn't extract the files from the .APK!\nPlease watch the tutorial by pressing OK.",
				'Error!');
			FlxG.openURL('https://youtu.be/zjvkTmdWvfU');
			System.exit(1);
		}
		else if ((FileSystem.exists(SUtil.getPath() + 'assets') && !FileSystem.isDirectory(SUtil.getPath() + 'assets'))
			&& (FileSystem.exists(SUtil.getPath() + 'mods') && !FileSystem.isDirectory(SUtil.getPath() + 'mods')))
		{
			Lib.application.window.alert("Why did you create two files called assets and mods instead of copying the folders from the .APK?, expect a crash.",
				'Error!');
			System.exit(1);
		}
		else
		{
			if (!FileSystem.exists(SUtil.getPath() + 'assets'))
			{
				Lib.application.window.alert("Whoops, seems like you didn't extract the assets/assets folder from the .APK!\nPlease watch the tutorial by pressing OK.",
					'Error!');
				FlxG.openURL('https://youtu.be/zjvkTmdWvfU');
				System.exit(1);
			}
			else if (FileSystem.exists(SUtil.getPath() + 'assets') && !FileSystem.isDirectory(SUtil.getPath() + 'assets'))
			{
				Lib.application.window.alert("Why did you create a file called assets instead of copying the assets directory from the .APK?, expect a crash.",
					'Error!');
				System.exit(1);
			}

			if (!FileSystem.exists(SUtil.getPath() + 'mods'))
			{
				Lib.application.window.alert("Whoops, seems like you didn't extract the assets/mods folder from the .APK!\nPlease watch the tutorial by pressing OK.",
					'Error!');
				FlxG.openURL('https://youtu.be/zjvkTmdWvfU');
				System.exit(1);
			}
			else if (FileSystem.exists(SUtil.getPath() + 'mods') && !FileSystem.isDirectory(SUtil.getPath() + 'mods'))
			{
				Lib.application.window.alert("Why did you create a file called mods instead of copying the mods directory from the .APK?, expect a crash.",
					'Error!');
				System.exit(1);
			}
		}
	}
	#end
    }

    //Thanks Forever Engine
    static public function gameCrashCheck(){
    	Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
    }
     
    static public function onCrash(e:UncaughtErrorEvent):Void {
			var callStack:Array<StackItem> = CallStack.exceptionStack(true);
			var errMsg:String = '';

			for (stackItem in callStack)
			{
				switch (stackItem)
				{
					case CFunction:
						errMsg += 'a C function\n';
					case Module(m):
						errMsg += 'module ' + m + '\n';
					case FilePos(s, file, line, column):
						errMsg += file + ' (line ' + line + ')\n';
					case Method(cname, meth):
						errMsg += cname == null ? "<unknown>" : cname + '.' + meth + '\n';
					case LocalFunction(n):
						errMsg += 'local function ' + n + '\n';
				}
			}


			#if (sys && !ios)
			try
			{
				if (!FileSystem.exists(SUtil.getPath() + 'logs'))
					FileSystem.createDirectory(SUtil.getPath() + 'logs');

				File.saveContent(SUtil.getPath()
					+ 'logs/'
					+ Lib.application.meta.get('file')
					+ '-'
					+ Date.now().toString().replace(' ', '-').replace(':', "'")
					+ '.log',
					errMsg
					+ '\n');
			}
			#if android
			catch (e:Dynamic)
			Toast.makeText("Error!\nClouldn't save the crash dump because:\n" + e, Toast.LENGTH_LONG);
			#end
			#end

			println(errMsg);
			Lib.application.window.alert(errMsg, 'Error!');
			System.exit(1);
		};
	
    public static function applicationAlert(title:String, description:String){
        Application.current.window.alert(description, title);
    }

    static public function saveContent(fileName:String = "file", fileExtension:String = ".json", fileData:String = "you forgot something to add in your code"){
                if (!FileSystem.exists(SUtil.getPath() + "saves")){
			FileSystem.createDirectory(SUtil.getPath() + "saves");
		}

		File.saveContent(SUtil.getPath() + "saves/" + fileName + fileExtension, fileData);
		SUtil.applicationAlert("Done Action :)", "File Saved Successfully!");
	}
}
