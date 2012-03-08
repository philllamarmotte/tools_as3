package hs.com.logs {
	import com.adobe.serialization.json.JSON;
	
	import flash.errors.IOError;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import hs.com.logs.LOGSStatus;
	
	public class LOGSExchange extends URLLoader {
		
		private var _URLRequest		:URLRequest;
		
		private var _header			:URLRequestHeader;
		
		private var params			:Object = new Object;
		
		public function LOGSExchange(level:int, message:String, parameters:Object=null) {
			new URLLoader();
			
			this.params	= {
				level		: level,
				message		: message,
				header		: "FlashReferer",
				callback	: ""
			};
			this.edit_params(parameters);
			
			this.params_URLRequest(this.params);
		}
		
		public function exchange():void {
			try {
				this.load(this._URLRequest);
			} catch (e:Error) {
				trace("-[ERROR] "+e);
			} catch (e:IOError) {
				trace("-[IOError] "+e);
			}
		}
		
		private function byteArrayparams(o:Object):ByteArray {
			var temp_var:String = JSON.encode(o);
			var temp_byteArray:ByteArray = new ByteArray();
			temp_byteArray.writeUTFBytes(temp_var);
			
			return temp_byteArray;
		}
		
		private function params_URLRequest(o:Object):void {
			o.message = "[FLASH] "+o.message;
			
			this._URLRequest	= new URLRequest(this.params.callback);
			
			this._header		= new URLRequestHeader(this.params.header, String(ExternalInterface.call("function _referer(){return \"http://\"+location.host+location.pathname+location.search;}")));
			this._URLRequest.requestHeaders.push(this._header);
			
			this._URLRequest.data = this.byteArrayparams(o);
			this._URLRequest.method = URLRequestMethod.POST;
		}
		
		private function edit_params(parameters:Object):void {
			if (parameters != null) {
				for (var parameter:String in parameters) {
					params[parameter] = parameters[parameter];
				}
			}
		}
	}
}