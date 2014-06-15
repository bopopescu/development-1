/**
 * This is the base coldfusion component that provides generic functionality.  All other colfusion components can safely extend this component.
 *
 * @author bsterner
 * @date 6/14/14
 **/
component displayname="Abstract Base Coldfusion Component" accessors=true output=false persistent=false {

	property name="name" displayname="Name" hint="Coldfusion compoent name" type="string";
	property name="id" displayname="ID" hint="ID used for generic unique identification" type="string";

	public string function getName() output="false" {
		return name;
	}

	public string function getId() output="false" {
		return id;
	}

	package Struct function toString(string returnFormat="struct" displayName="Return Format" hint="Can be used to change the format in which the representation data is returned (for example  struct vs array vs string)") displayname="toString" hint="Provides human readable string representation of component as opposed to object memory address representation." output="true" {
		/* TODO: Implement Method */
		return "";
	}
}