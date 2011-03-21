package app.model.data 
{
	/**
	 * QuestionData Class
	 *
	 * @author Luciana Maria Gerhard (marie@marie.art.br)
	 */
	public class QuestionData 
	{
		
	//--------------------------------------------
	//  Private attributes
	//--------------------------------------------
		/**
		 * @private
		 */
		private var _answers:AnswerDataIterator;
		
		/**
		 * @private
		 */
		private var _id:int;
		
		/**
		 * @private
		 */
		private var _text:String;
				
	//--------------------------------------------
	//  Constructor
	//--------------------------------------------
		
		/**
		 * Creates a new instance of <code>QuestionData</code>.
		 */
		public function QuestionData()
		{
		}
		
	//---------------------------------------------------------------------------------------------- 
	//
	//  Getters / Setters
	//  
	//----------------------------------------------------------------------------------------------		
		
		/**
		 *  Question's answers
		 */
		public function get answers():AnswerDataIterator  
		{
			return this._answers; 
		}
		
		public function set answers(value:AnswerDataIterator):void 
		{
			this._answers = value;
		}
		
		
		/**
		 *  Question id
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
		 * Question text
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