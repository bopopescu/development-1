/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component persistent="true" table="ORDERITEMS"{

	property name="ORDERITEMID" ormtype="integer" type="numeric" fieldtype="id" generator="native";
	property name="ORDERID" ormtype="integer" type="numeric";
	property name="ARTID" ormtype="integer" type="numeric";
	property name="PRICE" ormtype="float" type="numeric";

	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public orderitems function init() {
		return This;
	}

	/**
	* @hint Nullifies blank or zero id's.  Useful for dealing with objects coming back from remoting.
	*/
	public void function nullifyZeroID() {
		if (getORDERITEMID() eq 0 OR getORDERITEMID() eq ""){
			setORDERITEMID(JavaCast("Null", ""));
		}
	}

	/**
	* @hint Populates the content of the object from a form structure.
	*/
	public orderitems function populate(required struct formStruct ) {
		if (StructKeyExists(arguments.formstruct, "ORDERITEMID") AND arguments.formstruct.ORDERITEMID gt 0){

			var item = EntityLoad("orderitems", arguments.formstruct.ORDERITEMID, true);

			if (not isNull(item)){
				This = item;
			}
			else{
				This.setORDERITEMID(arguments.formstruct.ORDERITEMID);
			}
		}

		if (StructKeyExists(arguments.formstruct, "ORDERID")){
			This.setORDERID(arguments.formstruct.ORDERID);
		}

		if (StructKeyExists(arguments.formstruct, "ARTID")){
			This.setARTID(arguments.formstruct.ARTID);
		}

		if (StructKeyExists(arguments.formstruct, "PRICE")){
			This.setPRICE(arguments.formstruct.PRICE);
		}

		return This;
	}
}