/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component persistent="true" table="ORDERS"{

	property name="ORDERID" ormtype="integer" type="numeric" fieldtype="id" generator="native";
	property name="TAX" ormtype="float" type="numeric";
	property name="TOTAL" ormtype="float" type="numeric";
	property name="ORDERDATE" ormtype="timestamp" type="date";
	property name="ORDERSTATUSID" ormtype="integer" type="numeric";
	property name="CUSTOMERFIRSTNAME" type="string";
	property name="CUSTOMERLASTNAME" type="string";
	property name="ADDRESS" type="string";
	property name="CITY" type="string";
	property name="STATE" type="string";
	property name="POSTALCODE" type="string";
	property name="PHONE" type="string";

	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public orders function init() {
		return This;
	}

	/**
	* @hint Nullifies blank or zero id's.  Useful for dealing with objects coming back from remoting.
	*/
	public void function nullifyZeroID() {
		if (getORDERID() eq 0 OR getORDERID() eq ""){
			setORDERID(JavaCast("Null", ""));
		}
	}

	/**
	* @hint Populates the content of the object from a form structure.
	*/
	public orders function populate(required struct formStruct ) {
		if (StructKeyExists(arguments.formstruct, "ORDERID") AND arguments.formstruct.ORDERID gt 0){

			var item = EntityLoad("orders", arguments.formstruct.ORDERID, true);

			if (not isNull(item)){
				This = item;
			}
			else{
				This.setORDERID(arguments.formstruct.ORDERID);
			}
		}

		if (StructKeyExists(arguments.formstruct, "TAX")){
			This.setTAX(arguments.formstruct.TAX);
		}

		if (StructKeyExists(arguments.formstruct, "TOTAL")){
			This.setTOTAL(arguments.formstruct.TOTAL);
		}

		if (StructKeyExists(arguments.formstruct, "ORDERDATE")){
			This.setORDERDATE(arguments.formstruct.ORDERDATE);
		}

		if (StructKeyExists(arguments.formstruct, "ORDERSTATUSID")){
			This.setORDERSTATUSID(arguments.formstruct.ORDERSTATUSID);
		}

		if (StructKeyExists(arguments.formstruct, "CUSTOMERFIRSTNAME")){
			This.setCUSTOMERFIRSTNAME(arguments.formstruct.CUSTOMERFIRSTNAME);
		}

		if (StructKeyExists(arguments.formstruct, "CUSTOMERLASTNAME")){
			This.setCUSTOMERLASTNAME(arguments.formstruct.CUSTOMERLASTNAME);
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

		if (StructKeyExists(arguments.formstruct, "PHONE")){
			This.setPHONE(arguments.formstruct.PHONE);
		}

		return This;
	}
}