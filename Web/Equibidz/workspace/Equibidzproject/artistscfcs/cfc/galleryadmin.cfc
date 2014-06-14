/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component persistent="true" table="GALLERYADMIN"{

	property name="GALLERYADMINID" ormtype="integer" type="numeric" fieldtype="id" generator="native";
	property name="FIRSTNAME" type="string";
	property name="LASTNAME" type="string";
	property name="EMAIL" type="string";
	property name="ADMINPASSWORD" type="string";

	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public galleryadmin function init() {
		return This;
	}

	/**
	* @hint Nullifies blank or zero id's.  Useful for dealing with objects coming back from remoting.
	*/
	public void function nullifyZeroID() {
		if (getGALLERYADMINID() eq 0 OR getGALLERYADMINID() eq ""){
			setGALLERYADMINID(JavaCast("Null", ""));
		}
	}

	/**
	* @hint Populates the content of the object from a form structure.
	*/
	public galleryadmin function populate(required struct formStruct ) {
		if (StructKeyExists(arguments.formstruct, "GALLERYADMINID") AND arguments.formstruct.GALLERYADMINID gt 0){

			var item = EntityLoad("galleryadmin", arguments.formstruct.GALLERYADMINID, true);

			if (not isNull(item)){
				This = item;
			}
			else{
				This.setGALLERYADMINID(arguments.formstruct.GALLERYADMINID);
			}
		}

		if (StructKeyExists(arguments.formstruct, "FIRSTNAME")){
			This.setFIRSTNAME(arguments.formstruct.FIRSTNAME);
		}

		if (StructKeyExists(arguments.formstruct, "LASTNAME")){
			This.setLASTNAME(arguments.formstruct.LASTNAME);
		}

		if (StructKeyExists(arguments.formstruct, "EMAIL")){
			This.setEMAIL(arguments.formstruct.EMAIL);
		}

		if (StructKeyExists(arguments.formstruct, "ADMINPASSWORD")){
			This.setADMINPASSWORD(arguments.formstruct.ADMINPASSWORD);
		}

		return This;
	}
}