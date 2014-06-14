/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component persistent="true" table="MEDIA"{

	property name="MEDIAID" ormtype="integer" type="numeric" fieldtype="id" generator="native";
	property name="MEDIATYPE" type="string";

	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public media function init() {
		return This;
	}

	/**
	* @hint Nullifies blank or zero id's.  Useful for dealing with objects coming back from remoting.
	*/
	public void function nullifyZeroID() {
		if (getMEDIAID() eq 0 OR getMEDIAID() eq ""){
			setMEDIAID(JavaCast("Null", ""));
		}
	}

	/**
	* @hint Populates the content of the object from a form structure.
	*/
	public media function populate(required struct formStruct ) {
		if (StructKeyExists(arguments.formstruct, "MEDIAID") AND arguments.formstruct.MEDIAID gt 0){

			var item = EntityLoad("media", arguments.formstruct.MEDIAID, true);

			if (not isNull(item)){
				This = item;
			}
			else{
				This.setMEDIAID(arguments.formstruct.MEDIAID);
			}
		}

		if (StructKeyExists(arguments.formstruct, "MEDIATYPE")){
			This.setMEDIATYPE(arguments.formstruct.MEDIATYPE);
		}

		return This;
	}
}