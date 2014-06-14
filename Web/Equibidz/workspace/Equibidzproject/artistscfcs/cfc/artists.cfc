/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component persistent="true" table="ARTISTS"{

	property name="ARTISTID" ormtype="integer" type="numeric" fieldtype="id" generator="native";
	property name="FIRSTNAME" type="string";
	property name="LASTNAME" type="string";
	property name="ADDRESS" type="string";
	property name="CITY" type="string";
	property name="STATE" type="string";
	property name="POSTALCODE" type="string";
	property name="EMAIL" type="string";
	property name="PHONE" type="string";
	property name="FAX" type="string";
	property name="THEPASSWORD" type="string";

	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public artists function init() {
		return This;
	}

	/**
	* @hint Nullifies blank or zero id's.  Useful for dealing with objects coming back from remoting.
	*/
	public void function nullifyZeroID() {
		if (getARTISTID() eq 0 OR getARTISTID() eq ""){
			setARTISTID(JavaCast("Null", ""));
		}
	}

	/**
	* @hint Populates the content of the object from a form structure.
	*/
	public artists function populate(required struct formStruct ) {
		if (StructKeyExists(arguments.formstruct, "ARTISTID") AND arguments.formstruct.ARTISTID gt 0){

			var item = EntityLoad("artists", arguments.formstruct.ARTISTID, true);

			if (not isNull(item)){
				This = item;
			}
			else{
				This.setARTISTID(arguments.formstruct.ARTISTID);
			}
		}

		if (StructKeyExists(arguments.formstruct, "FIRSTNAME")){
			This.setFIRSTNAME(arguments.formstruct.FIRSTNAME);
		}

		if (StructKeyExists(arguments.formstruct, "LASTNAME")){
			This.setLASTNAME(arguments.formstruct.LASTNAME);
		}

		if (StructKeyExists(arguments.formstruct, "ADDRESS")){
			This.setADDRESS(arguments.formstruct.ADDRESS);
		}

		if (StructKeyExists(arguments.formstruct, "CITY")){
			This.setCITY(arguments.formstruct.CITY);
		}

		if (StructKeyExists(arguments.formstruct, "STATE")){
			This.setSTATE(arguments.formstruct.STATE);
		}

		if (StructKeyExists(arguments.formstruct, "POSTALCODE")){
			This.setPOSTALCODE(arguments.formstruct.POSTALCODE);
		}

		if (StructKeyExists(arguments.formstruct, "EMAIL")){
			This.setEMAIL(arguments.formstruct.EMAIL);
		}

		if (StructKeyExists(arguments.formstruct, "PHONE")){
			This.setPHONE(arguments.formstruct.PHONE);
		}

		if (StructKeyExists(arguments.formstruct, "FAX")){
			This.setFAX(arguments.formstruct.FAX);
		}

		if (StructKeyExists(arguments.formstruct, "THEPASSWORD")){
			This.setTHEPASSWORD(arguments.formstruct.THEPASSWORD);
		}

		return This;
	}
}