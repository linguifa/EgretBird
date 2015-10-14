package
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.filesystem.File;
	import flash.net.SharedObject;
	import flash.utils.Dictionary;

	public class FileManager
	{
		public function FileManager()
		{
			
		}
		
		
		public  static function setPackPath(key:String,path:String):void
		{
			var shareObj:SharedObject = SharedObject.getLocal("PackConfig");
			if(shareObj.data.pathConfig == null)
			{
				shareObj.data.pathConfig = new Dictionary();
			}
			shareObj.data.pathConfig[key] = path;
			shareObj.flush();
			
		}
		
		public  static function getPackPath(key:String):String
		{
			var shareObj:SharedObject = SharedObject.getLocal("PackConfig");
			if(shareObj.data.pathConfig == null)
			{
				shareObj.data.pathConfig = new Dictionary();
			}
			
			return shareObj.data.pathConfig[key] == null ? "":shareObj.data.pathConfig[key];
			
		}
		
	 
		/**
		 *
		 *  转换代码 
		*/
	 
		public static function changeCode(codeStr:String):String
		{
			
			var codeStr:String = codeStr;
			var array:Array = codeStr.split("\n");
			var reg:RegExp = new RegExp(" id=\"(.*?)\"","ig");
			var resultStr:String = "";//结果
			for each (var str:String in array)
			{
				//搜索空格符
				var space:String = str.substr(str.indexOf(":") + 1);
				
				//从：冒号开始搜索
				var startIndex:int = str.indexOf(":") + 1;
				var endIndex:int = startIndex + space.indexOf(" ");//以第一个空格符结束为标记
				var typeStr:String = str.substring(startIndex,endIndex);//egret的类型
				
				var temp:Array = str.match(reg);
				if (temp && temp[0])
				{
					var idStr:String = String(temp[0]).replace("id=",'').replace("\"",'').replace("\"",'');
					resultStr +=  "private #1: egret.gui.#2;".replace("#1",idStr).replace("#2",typeStr) + "\n";
				}
			}
			
			return resultStr;
		}
	}
}