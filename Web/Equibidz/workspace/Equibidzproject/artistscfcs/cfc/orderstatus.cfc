/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component persistent="true" table="ORDERSTATUS"{

	property name="ORDERSTATUSID" ormtype="integer" type="numeric" fieldtype="id" generator="native";
	property name="STATUS" type="string";

	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public orderstatus function init() {
		return This;
	}

	/**
	* @hint Nullifies blank or zero id's.  Useful for dealing with objects coming back from remoting.
	*/
	public void function nullifyZeroID() {
		if (getORDERSTATUSID() eq 0 OR getORDERSTATUSID() eq ""){
			setORDERSTATUSID(JavaCast("Null", ""));
		}
	}

	/**
	* @hint Populates the content of the object from a form structure.
	*/
	public orderstatus function populate(required struct formStruct ) {
		if (StructKeyExists(arguments.formstruct, "ORDERSTATUSID") AND arguments.formstruct.ORDERSTATUSID gt 0){

			var item = EntityLoad("orderstatus", arguments.formstruct.ORDERSTATUSID, true);

			if (not isNull(item)){
				This = item;
			}
			else{
				This.setORDERSTATUSID(arguments.formstruct.ORDERSTATUSID);
			}
		}

		if (StructKeyExists(arguments.formstruct, "STATUS")){
			This.setSTATUS(arguments.formstruct.STATUS);
		}

		return This;
	}
}