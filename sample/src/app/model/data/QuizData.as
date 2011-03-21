package app.model.data
{
	/**
	 * QuizData Class
	 *
	 * @author Luciana Maria Gerhard (marie@marie.art.br)
	 */
	public class QuizData
	{
		//--------------------------------------------
		//	Public attributes
		//--------------------------------------------
		
		public var introduction:String;
		
		public var link:LinkData;
		
		public var messages:Vector.<String>;
		
		public var questions:QuestionDataIterator;
		//--------------------------------------------
		//	Constructor
		//--------------------------------------------
		
		/**
		 * Creates a new instance of <code>QuizData</code>.
		 */
		public function QuizData()
		{
		}
	}
}