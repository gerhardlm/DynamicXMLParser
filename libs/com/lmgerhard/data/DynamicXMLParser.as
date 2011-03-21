package com.lmgerhard.data
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	//--------------------------------------------
	//  Constructor
	//--------------------------------------------
	/**
	 * DynamicXMLParser Class
	 *
	 * @author Luciana M Gerhard (marie@marie.art.br)
	 */
	public class DynamicXMLParser
	{

	//----------------------------------------------------------------------------------------------
	//
	//	Public methods
	//
	//----------------------------------------------------------------------------------------------
		
		/**
		 * Parse a list of nodos of same type.
		 * @param xmlList XML with list of objects
		 * @param objClass Class will store XML data.
		 * @return Object required parameter Class with filled data
		 * 
		 */		
		public static function parseList(xmlItensList:XML, objClass:Class):Object
		{
			var vecObjects:Vector.<Object> = new Vector.<Object>();
			
			var classDescriptionXML:XML = describeType(objClass);
			var vectorClass:String;
			var objectTypeOfVectorParameterOnConstructor:String = "";
			
			// Verify if object waits a required parameter
			if(classDescriptionXML.factory.constructor.parameter.length() > 0)
			{
				if(classDescriptionXML.factory.constructor.length() > 0)
				{
					var parameterNode:XML;
					
					for (var l:int = 0; l<classDescriptionXML.factory.constructor.parameter.length(); l++)
					{
						parameterNode = classDescriptionXML.factory.constructor.parameter[l];
						
						if(parameterNode.@optional == "false")
						{
							// Verify is required parameter of constructor is a Vector
							if(parameterNode.@type.indexOf("Vector") > -1)
							{
								vectorClass = String(parameterNode.@type);
								objectTypeOfVectorParameterOnConstructor = parameterNode.@type.slice(parameterNode.@type.indexOf("Vector.<")+8, parameterNode.@type.indexOf(">"));
							}
							else
							{
								throw new Error("ERROR! Class "+objClass+" is waiting a required parameter on constructor thats not a Vector. Parse will not be done.");
							}
						}
					}
				}
			}
			
			
			var variablesList:XMLList = classDescriptionXML.factory.variable;
			var setsList:XMLList = classDescriptionXML.factory.accessor;
			
			var ClassReference:Class;
			
			var variable:String;
			var xmlVariableContent:XMLList;
			
			// parse list without required parameter on constructor
			if(objectTypeOfVectorParameterOnConstructor == "")
			{
				// create new object instance
				var object:Object = new objClass();
				var returnObject:Boolean = false;
				
				// loop all class variables
				for (var j:int; j < variablesList.length(); j++)
				{
					variable = variablesList[j].@name;
					
					xmlVariableContent = xmlItensList.child(variable);
					
					ClassReference = getDefinitionByName(variablesList[j].@ type) as Class;
					
					// verify if variable exists in class and xml.
					if (xmlVariableContent.length() > 0)
					{
						returnObject = true;
						object[variable] = addContent(ClassReference, xmlVariableContent);
					}
					else if(xmlItensList.name() == variable)
					{
						returnObject = true;
						object[variable] = addContent(ClassReference, XMLList(xmlItensList.toXMLString()));
					}
				}
				
				// loop all setters and getters
				for (var k:int = 0; k < setsList.length(); k++)
				{
					variable = setsList[k].@name;
					
					
					if (setsList[k].@access.indexOf("write") > -1)
					{
						xmlVariableContent = xmlItensList.child(variable);
						
						ClassReference = getDefinitionByName(setsList[k]. @ type) as Class;
						
						// verify if variable exists in class and xml.
						if (xmlVariableContent.length() > 0)
						{
							returnObject = true;
							object[variable] = addContent(ClassReference, xmlVariableContent);
						}
						else if(xmlItensList.name() == variable)
						{
							returnObject = true;
							object[variable] = addContent(ClassReference, XMLList(xmlItensList.toXMLString()));
						}
					}
				}

				if(returnObject)
					return object;
				
				// loop elements list, returning a vector
				for each (var xmlNode:XML in xmlItensList.children())
					vecObjects.push(parseNode(xmlNode, objClass));

				return vecObjects;
			}
			else
			{
				// retrieve list type by the required parameter in constructor of returning class
				var vectorObject:Class = getDefinitionByName(vectorClass.toString()) as Class;
				
				var vectorDataObject:Class = getDefinitionByName(objectTypeOfVectorParameterOnConstructor) as Class;

				return new objClass(vectorObject(parseList(xmlItensList, vectorDataObject)));
			}
			
			return new Object;
		}

		/**
		 * Parse a xml node.
		 * 
		 * @param xmlNode XML data
		 * @param objClass Class will store XML data.
		 * @return Object required parameter Class with filled data
		 */		
		public static function parseNode(xmlNode:XML, objClass:Class):Object
		{
			// retrieve all class information as xml
			var objDescriptionXML:XML = describeType(objClass);
			
			// set a list of class variables
			var variablesList:XMLList = objDescriptionXML.factory.variable;
			// set a list of class setters
			var setsList:XMLList = objDescriptionXML.factory.accessor;
			
			var ClassReference:Class;

			var variable:String;
			var xmlVariableContent:XMLList;
			
			var castAsType:Boolean = true;
			
			// Verify if object waits a required parameter
			if(objDescriptionXML.factory.constructor.parameter.length() > 0)
			{
				if(objDescriptionXML.factory.constructor.length() > 0)
				{
					var parameterNode:XML;
					
					for (var l:int = 0; l<objDescriptionXML.factory.constructor.parameter.length(); l++)
					{
						parameterNode = objDescriptionXML.factory.constructor.parameter[l];
						
						if(parameterNode.@optional == "false")
						{
							throw new Error("ERROR! Class "+objClass+" is waiting a required parameter in construtor. Parse will not be done");
						}
					}
				}
			}
			
			// Verify if object doesnt has variables or setters
			// and build it as object type
			if(variablesList.length() == 0)
			{
				for (var i:int = 0; i < setsList.length(); i++)
				{
					if(setsList[i]. @ access.indexOf("write") > -1)
						castAsType = false;
				}
				
				if(castAsType)
				{
					if(objClass === Boolean)
						return returnBoolean(xmlNode[0]);
					else
						return  objClass(xmlNode[0]);
				}
			}
			
			// create new object instance
			var object:Object = new objClass();

			// loop all class variables
			for (var j:int; j < variablesList.length(); j++)
			{
				variable = variablesList[j].@name;
				
				xmlVariableContent = xmlNode.child(variable);

				ClassReference = getDefinitionByName(variablesList[j].@ type) as Class;
				
				// verify if variable exists in class and xml.
				if (xmlVariableContent.length() > 0)
				{
					object[variable] = addContent(ClassReference, xmlVariableContent);
				}
				else if(xmlNode.@[variable].length() > 0)
				{
					if(ClassReference === Boolean)
						object[variable] = returnBoolean(xmlNode.@[variable]);
					else
						object[variable] = new ClassReference(xmlNode.@[variable]);
				}
			}
			
			
			// loop all setters and getters
			for (var k:int = 0; k < setsList.length(); k++)
			{
				variable = setsList[k]. @ name;
				
				if (setsList[k]. @ access.indexOf("write") > -1)
				{
					xmlVariableContent = xmlNode.child(variable);
					
					// verify if xml node name is equal to variable
					if(xmlVariableContent.length() == 0 && variable == xmlNode.name())
						xmlVariableContent = XMLList(xmlNode);
					
					ClassReference = getDefinitionByName(setsList[k]. @ type) as Class;
					
					// verify if variable exists in class and xml.
					if (xmlVariableContent.length() > 0)
					{
						object[variable] = addContent(ClassReference, xmlVariableContent);
					}
					else if(xmlNode.@[variable].length() > 0)
					{
						if(ClassReference === Boolean)
							object[variable] = returnBoolean(xmlNode.@[variable]);
						else
							object[variable] = new ClassReference(xmlNode.@[variable]);
					}
				}
			}
			return object;
		}
		
	//----------------------------------------------------------------------------------------------
	//
	//	Private methods
	//
	//----------------------------------------------------------------------------------------------
		
		/**
		 * Fill class with xml content
		 * @param ClassReference Class instance
		 * @param xmlContent XML data
		 * @return 
		 */
		private static function addContent(ClassReference:Class, xmlContent:XMLList):Object
		{
			var newXML:XML;
			
			// verify if xml node has children
			if(xmlContent.length() > 1)
			{
				// Add a fake list in case of xml data has a list of nodes
				// with the same name that arent part of a node
				newXML = XML("<xml><group>"+String(xmlContent)+"</group></xml>");
				return verifyTypeAndParseContent(ClassReference, newXML.children());
			}
			else
			{
				var nodeNumChildren:int = xmlContent[0].children().length();
				if(nodeNumChildren > 1)
				{	
					// add a list of items
					return verifyTypeAndParseContent(ClassReference, xmlContent);
				}
				else
				{
					if(xmlContent[0].toString().length == 0 && xmlContent.attributes().length() > 0)
					{
						// xml node with attributes without content
						newXML = XML("<xml><group>"+xmlContent.toXMLString()+"</group></xml>");
						return verifyTypeAndParseContent(ClassReference, newXML.children());
					}
					else if(xmlContent.children().length() > 0)
					{
						if(xmlContent[xmlContent.children()[0].name()].length() > 0)
							return verifyTypeAndParseContent(ClassReference, xmlContent);
					}
					
					if(ClassReference === Boolean)
						return returnBoolean(xmlContent);
					else
						return new ClassReference(xmlContent);
				}
			}
			
			throw new Error("No content has been added. Incorrect structure of XML not recognized in the parse.");
		}
		
		
		/**
		 * Returns the boolean of a string value
		 * @param content
		 * @return boolean
		 */
		private static function returnBoolean(content:String):Boolean
		{
			switch(content)
			{
				case "1": 
				case "true": 
				case "yes":  
				case "sim":  
				{
					return true;
				}     
				case "0":     
				case "false":     
				case "no": 
				case "nao": 
				{
					return false;
				}     
				default:         
				{
					return Boolean(content);
				}
			}
		}
		
		/**
		 * Verify the type of data the class waits and parse content
		 * @param ClassReference Class instance
		 * @param xmlContent XML data
		 * @return 
		 * 
		 */		
		private static function verifyTypeAndParseContent(ClassReference:Class, xmlContent:XMLList):Object
		{
			var classReferenceStr:String = String(ClassReference as Class);
			var type:String;
			var objClassReference:Class;
			
			// verify if contents children are items with same node name
			if(xmlContent.children().length() == xmlContent[xmlContent.children()[0].name()].length())
			{
				var objDescriptionXML:XML = describeType(ClassReference);
				
				// retrieve object type
				if(classReferenceStr.indexOf("Vector.<") > -1)
				{
					type = classReferenceStr.slice(classReferenceStr.indexOf("Vector.<")+8, classReferenceStr.indexOf(">"));
					objClassReference = getDefinitionByName(type) as Class;
					
					return ClassReference(parseList(XML(xmlContent), objClassReference));
				}
				else
				{
					if(objDescriptionXML.factory.constructor.length() > 0)
					{
						var parameterNode:XML;
						var listType:Class;
						
						if(objDescriptionXML.factory.constructor.parameter.length() > 1)
						{
							throw new Error("Returning class "+ClassReference+" must have only one required parameter of type Vector, now it has more than one.");
						}

						parameterNode = objDescriptionXML.factory.constructor.parameter[0];
							
						if(parameterNode.@optional == "false")
						{
							type = parameterNode.@type;
							
							if(type.indexOf("Vector.<") > -1)
							{
								listType = getDefinitionByName(type) as Class;
								
								type = type.slice(type.indexOf("Vector.<")+8, type.indexOf(">"));
								objClassReference = getDefinitionByName(type) as Class;
								
								return new ClassReference(listType(parseList(XML(xmlContent), objClassReference)));
							}
							else
							{
								objClassReference = getDefinitionByName(type) as Class;
								throw new Error("List parse must wait a Vector, now its waiting "+objClassReference+".");
							}
						}
						else
						{
								throw new Error("Class "+ClassReference+" must wait a REQUIRED parameter of type Vector.");
						}
					}
				}	
			}
			else
			{
				return ClassReference(parseNode(XML(xmlContent), ClassReference));
			}
			return null;
		}
	}
}