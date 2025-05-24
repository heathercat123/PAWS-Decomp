package
{
   import flash.utils.Dictionary;
   
   public class StringsManager
   {
      
      public static var xml:XML;
      
      public static var dictionary:Dictionary;
      
	  [Embed(source="../strings/english.xml", mimeType="application/octet-stream")]
      public static const StringXML:Class;
      
	  [Embed(source="../strings/italian.xml", mimeType="application/octet-stream")]
      public static const StringXML_it:Class;
      
	  [Embed(source="../strings/deutsch.xml", mimeType="application/octet-stream")]
      public static const StringXML_de:Class;
      
	  [Embed(source="../strings/spanish.xml", mimeType="application/octet-stream")]
      public static const StringXML_es:Class;
      
	  [Embed(source="../strings/french.xml", mimeType="application/octet-stream")]
      public static const StringXML_fr:Class;
      
	  [Embed(source="../strings/portuguese.xml", mimeType="application/octet-stream")]
      public static const StringXML_pt:Class;
      
	  [Embed(source="../strings/russian.xml", mimeType="application/octet-stream")]
      public static const StringXML_ru:Class;
      
      public function StringsManager()
      {
         super();
      }
      
      public static function Init() : void
      {
         var __name:String = null;
         var __value:String = null;
         var string:XML = null;
         if(Utils.Lang == "_de")
         {
            xml = XML(new StringXML_de());
         }
         else if(Utils.Lang == "_es")
         {
            xml = XML(new StringXML_es());
         }
         else if(Utils.Lang == "_fr")
         {
            xml = XML(new StringXML_fr());
         }
         else if(Utils.Lang == "_it")
         {
            xml = XML(new StringXML_it());
         }
         else if(Utils.Lang == "_pt")
         {
            xml = XML(new StringXML_pt());
         }
         else if(Utils.Lang == "_ru")
         {
            xml = XML(new StringXML_ru());
         }
         else
         {
            xml = XML(new StringXML());
         }
         dictionary = new Dictionary();
         for each(string in xml.string)
         {
            __name = string.attribute("name");
            __value = string.attribute("value");
            dictionary[__name] = __value;
         }
      }
      
      public static function ReloadEnglishStrings() : void
      {
         var __name:String = null;
         var __value:String = null;
         var string:XML = null;
         xml = XML(new StringXML());
         dictionary = new Dictionary();
         for each(string in xml.string)
         {
            __name = string.attribute("name");
            __value = string.attribute("value");
            dictionary[__name] = __value;
         }
      }
      
      public static function GetString(value:String) : String
      {
         if(dictionary[value] == null)
         {
            return "STRING NOT FOUND";
         }
         return dictionary[value];
      }
   }
}

