package logs {
	import flash.net.URLLoader;
	
	import logs.LOGSStatus;
	
	public final class LOGS {
		
		public static function log(level:int, message:String, parameters:Object=null):void {
			var params		:Object = {
				mode	: LOGSStatus.DEBUG,
				console	: false
			};
			
			if (parameters != null) {
				for (var parameter:String in parameters) {
					params[parameter] = parameters[parameter];
				}
			}
			
			if (level >= params.mode) {
				if (params.console) new LOGSExchange(level, message, params).exchange();
				new LOGSTrace(level, message).console_debug();
			}
		}
		
		public static function get DEBUG():int {
			return LOGSStatus.DEBUG;
		}
		
		public static function get INFO():int {
			return LOGSStatus.INFO;
		}
		
		public static function get WARNING():int {
			return LOGSStatus.WARNING;
		}
		
		public static function get ERROR():int {
			return LOGSStatus.ERROR;
		}
		
		public static function get FATAL():int {
			return LOGSStatus.FATAL;
		}
	}
}