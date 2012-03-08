package hs.com.logs {
	
	import hs.com.logs.LOGSStatus;
	
	public class LOGSTrace {
		
		private var params			:Object = new Object;
		
		public function LOGSTrace(level:int, message:String) {
			this.params	= {
				level : level,
				message : message
			};
		}
		
		public function console_debug():void {
			switch (this.params.level) {
				case LOGSStatus.DEBUG :
					trace("-[DEBUG] "+this.params.message);
					break;
				case LOGSStatus.ERROR :
					trace("-[ERROR] "+this.params.message);
					break;
				case LOGSStatus.FATAL :
					trace("-[FATAL] "+this.params.message);
					break;
				case LOGSStatus.INFO :
					trace("-[INFO] "+this.params.message);
					break;
				case LOGSStatus.WARNING :
					trace("-[WARNING] "+this.params.message);
					break;
			}
		}
	}
}