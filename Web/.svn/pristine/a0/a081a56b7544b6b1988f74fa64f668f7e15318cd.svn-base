/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component{


	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public orderitemsService function init() {
		This.table = "ORDERITEMS";
		return This;
	}

	/**
	* @hint Returns the count of records in orderitems
	*/
	public numeric function count() {
		return ormExecuteQuery("select Count(*) from orderitems")[1];
	}

	/**
	* @hint Returns all of the records in orderitems.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orderitems[] function list() {
		return entityLoad("orderitems", {}, "ORDERITEMID asc");
	}

	/**
	* @hint Returns all of the records in orderitems, with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orderitems[] function listPaged(numeric offset ="0" , numeric maxresults ="0" , string orderby ="ORDERITEMID asc" ) {
		var loadArgs = {};
		if (arguments.offset neq 0){
			loadArgs.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			loadArgs.maxresults = arguments.maxresults;
		}
		return entityLoad("orderitems", {}, arguments.orderby, loadArgs);
	}

	/**
	* @hint Returns one record from orderitems.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orderitems function get(required numeric id ) {
		return EntityLoad("orderitems", arguments.id, true);
	}

	/**
	* @hint Updates one record from orderitems.
	*/
	public void function update(required any orderitems ) {
		arguments.orderitems.nullifyZeroID();
		EntitySave(arguments.orderitems);
	}

	/**
	* @hint Deletes one record from orderitems.
	*/
	public void function destroy(required any orderitems ) {
		EntityDelete(arguments.orderitems);
	}

	/**
	* @hint Performs search against orderitems.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orderitems[] function search(string q ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM orderitems";
		if (len(arguments.q) gt 0){
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
			hqlString = hqlString & " ORDER BY ORDERITEMID asc";
		return ormExecuteQuery(hqlString, false, params);
	}

	/**
	* @hint Performs search against orderitems., with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orderitems[] function searchPaged(string q , numeric offset ="0" , numeric maxresults ="0" , string orderby ="ORDERITEMID asc" ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM orderitems";
		if (arguments.offset neq 0){
			params.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			params.maxresults = arguments.maxresults;
		}
		if (len(arguments.q) gt 0){
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
			hqlString = hqlString & " ORDER BY #arguments.orderby#";
		return ormExecuteQuery(hqlString, false, params);
	}

	/**
	* @hint Determines total number of results of search for paging purposes.
	*/
	public numeric function searchCount(string q ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "SELECT count(*) ";
		hqlString = hqlString & "FROM orderitems";
		if (len(arguments.q) gt 0){
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
		return ormExecuteQuery(hqlString, false, params)[1];
	}
}