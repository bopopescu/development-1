/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component persistent="true" table="ART"{

	property name="ARTID" ormtype="integer" type="numeric" fieldtype="id" generator="native";
	property name="ARTISTID" ormtype="integer" type="numeric";
	property name="ARTNAME" type="string";
	property name="DESCRIPTION" ormtype="text" type="string";
	property name="PRICE" ormtype="float" type="numeric";
	property name="LARGEIMAGE" type="string";
	property name="MEDIAID" ormtype="integer" type="numeric";
	property name="ISSOLD" ormtype="integer" type="numeric";

	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public art function init() {
		return This;
	}

	/**
	* @hint Nullifies blank or zero id's.  Useful for dealing with objects coming back from remoting.
	*/
	public void function nullifyZeroID() {
		if (getARTID() eq 0 OR getARTID() eq ""){
			setARTID(JavaCast("Null", ""));
		}
	}

	/**
	* @hint Populates the content of the object from a form structure.
	*/
	public art function populate(required struct formStruct ) {
		if (StructKeyExists(arguments.formstruct, "ARTID") AND arguments.formstruct.ARTID gt 0){

			var item = EntityLoad("art", arguments.formstruct.ARTID, true);

			if (not isNull(item)){
				This = item;
			}
			else{
				This.setARTID(arguments.formstruct.ARTID);
			}
		}

		if (StructKeyExists(arguments.formstruct, "ARTISTID")){
			This.setARTISTID(arguments.formstruct.ARTISTID);
		}

		if (StructKeyExists(arguments.formstruct, "ARTNAME")){
			This.setARTNAME(arguments.formstruct.ARTNAME);
		}

		if (StructKeyExists(arguments.formstruct, "DESCRIPTION")){
			This.setDESCRIPTION(arguments.formstruct.DESCRIPTION);
		}

		if (StructKeyExists(arguments.formstruct, "PRICE")){
			This.setPRICE(arguments.formstruct.PRICE);
		}

		if (StructKeyExists(arguments.formstruct, "LARGEIMAGE")){
			This.setLARGEIMAGE(arguments.formstruct.LARGEIMAGE);
		}

		if (StructKeyExists(arguments.formstruct, "MEDIAID")){
			This.setMEDIAID(arguments.formstruct.MEDIAID);
		}

		if (StructKeyExists(arguments.formstruct, "ISSOLD")){
			This.setISSOLD(arguments.formstruct.ISSOLD);
		}

		return This;
	}
}