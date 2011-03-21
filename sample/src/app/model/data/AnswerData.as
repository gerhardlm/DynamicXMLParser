package app.model.data
{
	/**
	 * AnswerData Class
	 *
	 * @author Luciana Maria Gerhard (marie@marie.art.br)
	 */
	public class AnswerData 
	{
		
	//--------------------------------------------
	//  Private attributes
	//--------------------------------------------
		/**
		 * @private
		 */
		private var _correct:Boolean;
		
		/**
		 * @private
		 */
		private var _id:int;
		
		/**
		 * @private
		 */
		private var _text:String;
				
	//--------------------------------------------
	//  Construtor
	//--------------------------------------------
		
		/**
		 * Creates a new instance of <code>AnswerData</code>.
		 */
		public function AnswerData()
		{
		}
		
	//---------------------------------------------------------------------------------------------- 
	//
	//  Getters / Setters
	//  
	//----------------------------------------------------------------------------------------------		
		
		/**
		 * Answer is correct
		 */
		public function get correct():Boolean  
		{
			return this._correct; 
		}
		
		public function set correct(value:Boolean):void 
		{
			this._correct = value;
		}
		
		
		/**
		 *  Answer id
		 */
		public function get id():int  
		{
			return this._id; 
		}
		
		public function set id(value:int):void 
		{
			this._id = value;
		}
		
		
		/**
		 * Answer text
		 */
		public function get text():String  
		{
			return this._text; 
		}
		
		public function set text(value:String):void 
		{
			this._text = value;
		}
		
	}
}