package app
{
	import app.model.data.QuizData;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.display.Sprite;
	
	import com.lmgerhard.data.DynamicXMLParser;

	/**
	 * Sample class showing the use of DynamicXMLParser
	 * @author Luciana Gerhard (marie@marie.art.br)
	 */
	public class Application extends Sprite
	{
		
		public function Application()
		{
			loadXML();
		}
		
		private function loadXML():void
		{
			var _loader:URLLoader = new URLLoader(new URLRequest("_xml/quiz.xml"));
			_loader.addEventListener(Event.COMPLETE, handleLoadComplete);
		}
		
		private function handleLoadComplete(e:Event):void
		{
			var quizXML:XML = XML(URLLoader(e.target).data);
			
			var quizData:QuizData = QuizData(DynamicXMLParser.parseNode(quizXML, QuizData));
			
			trace(quizData.questions.last().text);
			trace(quizData.questions.last().answers.getAnswerById(2).text);
			trace(quizData.questions.last().answers.getAnswerById(2).correct);
		}
	}
}
