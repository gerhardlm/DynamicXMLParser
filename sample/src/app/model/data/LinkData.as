package app.model.data 
{
	/**
	 * LinkData Class
	 *
	 * @author Luciana Maria Gerhard (marie@marie.art.br)
	 */
	public class LinkData
	{
	//--------------------------------------------
	//	Public Attributes
	//--------------------------------------------
		
		public var text:String = "";
		
	//--------------------------------------------
	//	Private attributes
	//--------------------------------------------
		
		private var _path:String = "";
		private var _target:String = "";
		
	//--------------------------------------------
	//	Constructor
	//--------------------------------------------
		
		/**
		 * Creates a new instance of <code>LinkData</code>.
		 */
		 public function LinkData()
		{
		}
		
	//---------------------------------------------------------------------------------------------- 
	//
	//  Getters / Setters
	//  
	//----------------------------------------------------------------------------------------------		
	
		/**
		 * Link URL
		 */
		public function set path(value:String):void
		{
			_path = value;
		}
		
		public function get path():String
		{
			return _path;
		}
		
		/**
		 * link Target
		 */
		public function set target(value:String):void
		{
			_target = value;
		}
		
		public function get target():String
		{
			return _target;
		}
	}
}