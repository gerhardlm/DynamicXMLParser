package app.model.data
{
	
	/**
	 * AnswerDataIterator Class
	 *
	 * @author Luciana Maria Gerhard (marie@marie.art.br)
	 */
	public class AnswerDataIterator 
	{
		
	//--------------------------------------------
	//  Private attributes
	//--------------------------------------------
	
		/**
		 * @private
		 * Collection of elements.
		 */
		private var _collection:Vector.<AnswerData>;
		
		/**
		 * @private
		 * Navigations pointer between elements.
		 */
		private var _index:int = 0;
	
	//--------------------------------------------
	//  Constructor
	//--------------------------------------------
		
		/**
		 * Creates a new instance of <code>AnswerDataIterator</code>.
		 * @param collection Vector.<AnswerData>
		 */
		public function AnswerDataIterator(collection:Vector.<AnswerData>)
		{
			this._collection = collection;
			
			if (this._collection.length > 0)
			{
				this._index = 0;
			}
			else
			{
				this._index = -1;
			}
		}
		
	//----------------------------------------------------------------------------------------------
	//
	//	Public methods
	//
	//----------------------------------------------------------------------------------------------
		/**
		 * Inserts one more item in the collection of questions
		 */
		public function addAnswer(userData:AnswerData):void
		{
			this._collection.push(userData);	
		}
		
		/**
		 * Returns the first item in the collection and position the pointer beginning of it.
		 *
		 * @return AnswerData First element of the items
		 */
		public function first():AnswerData
		{
			if (this._collection.length > 0)
			{
				return this._collection[this._index = 0];
			}
			else
			{
				return null;
			}
		}
		
		
		/**
		 * Returns the item at position <code>position</code>.
		 *
		 * @return AnswerData Item at position <code>position</index>.
		 */
		public function getAt(position:int):AnswerData
		{
			if ((position >= 0) && (position < this._collection.length))
			{
				this._index = position;
				return this._collection[position];
			}
			else
			{
				return null;
			}
		}
		
		
		/**
		 * Returns <code>AnswerData</code> associated with id.
		 * 
		 * @return Instance of <code>AnswerData</code>.
		 */
		public function getAnswerById(id:int):AnswerData
		{
			var itemData:AnswerData = null;
			
			for (var i:int = 0; !itemData && (i < this._collection.length); i++)
			{
				if(this._collection[i].id == id)
					itemData = this._collection[i];
			}
			
			return itemData;
		}
		
		/**
		 * Returns <code>AnswerData</code> that is the right answer
		 * 
		 * @return Instance of <code>AnswerData</code>.
		 */
		public function getRightAnswer():AnswerData
		{
			for (var i:int = 0; i < this._collection.length; i++)
			{
				if(this._collection[i].correct)
					return this._collection[i];
			}
			
			return null;
		}
		
		/**
		 * Returns true if has a next item, false otherwise.
		 *
		 * @return Boolean
		 */
		public function hasNext():Boolean
		{
			return this._index < (this._collection.length - 1);
		}
		
		
		/**
		 * Returns true if has a previous item, false otherwise
		 * @return Boolean
		 */
		public function hasPrevious():Boolean
		{
			return this._index > 0;
		}
		
		
		/**
		 * Returns the last item in the collection and positions the
		 * pointer at the end of it.
		 *
		 * @return AnswerData last item of the collection
		 */
		public function last():AnswerData
		{
			if(this._collection.length > 0)
			{
				return this._collection[this._index = this._collection.length - 1];
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * Returns the next item in the collection and
		 * reposition the pointer.
		 *
		 * @return AnswerData collection item
		 */
		public function next():AnswerData
		{
			if (hasNext())
			{
				return this._collection[++this._index];
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * Returns the previous item in the collection and
		 * reposition the pointer.
		 *
		 * @return AnswerData collection item
		 */
		public function previous():AnswerData
		{
			if (hasPrevious())
			{
				return this._collection[--this._index];
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * Resets the iterator to the initial state.
		 */
		public function reset():void
		{
			if (this._collection.length > 0)
			{
				this._index = 0;
			}
			else
			{
				this._index = -1;
			}
		}
		
		
		/**
		 * Positions the current pointer at the desired item.
		 */
		public function setAtId(id:int):void
		{
			this.setOut("start");
			
			while (this.next() && (this.current.id != id)) { };
		}
		
		/**
		 * Position the pointer in a position beyond the limits of the vector
		 * to allow navigation while loop
		 */
		public function setOut(position:String = "start"):void
		{
			switch(position)
			{
				case "start": this._index = -1; break;
				case "end": this._index = this._collection.length; break;
			}
		}
		
		
		//----------------------------------------------------------------------------------------------
		//
		//	Getters / Setters
		//
		//----------------------------------------------------------------------------------------------
		
		/**
		 * Returns the index of current item.
		 */
		public function get index():int
		{
			return this._index;
		}
		
		/**
		 * Returns the current item.
		 */
		public function get current():AnswerData
		{
			return this.getAt(this._index);
		}
		
		/**
		 * Returns the lenght
		 */
		public function get length():int
		{
			return this._collection.length;
		}
	}
}