/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component{


	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public orderstatusService function init() {
		This.table = "ORDERSTATUS";
		return This;
	}

	/**
	* @hint Returns the count of records in orderstatus
	*/
	public numeric function count() {
		return ormExecuteQuery("select Count(*) from orderstatus")[1];
	}

	/**
	* @hint Returns all of the records in orderstatus.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orderstatus[] function list() {
		return entityLoad("orderstatus", {}, "ORDERSTATUSID asc");
	}

	/**
	* @hint Returns all of the records in orderstatus, with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orderstatus[] function listPaged(numeric offset ="0" , numeric maxresults ="0" , string orderby ="ORDERSTATUSID asc" ) {
		var loadArgs = {};
		if (arguments.offset neq 0){
			loadArgs.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			loadArgs.maxresults = arguments.maxresults;
		}
		return entityLoad("orderstatus", {}, arguments.orderby, loadArgs);
	}

	/**
	* @hint Returns one record from orderstatus.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orderstatus function get(required numeric id ) {
		return EntityLoad("orderstatus", arguments.id, true);
	}

	/**
	* @hint Updates one record from orderstatus.
	*/
	public void function update(required any orderstatus ) {
		arguments.orderstatus.nullifyZeroID();
		EntitySave(arguments.orderstatus);
	}

	/**
	* @hint Deletes one record from orderstatus.
	*/
	public void function destroy(required any orderstatus ) {
		EntityDelete(arguments.orderstatus);
	}

	/**
	* @hint Performs search against orderstatus.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orderstatus[] function search(string q ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM orderstatus";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " STATUS LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
			hqlString = hqlString & " ORDER BY ORDERSTATUSID asc";
		return ormExecuteQuery(hqlString, false, params);
	}

	/**
	* @hint Performs search against orderstatus., with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orderstatus[] function searchPaged(string q , numeric offset ="0" , numeric maxresults ="0" , string orderby ="ORDERSTATUSID asc" ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM orderstatus";
		if (arguments.offset neq 0){
			params.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			params.maxresults = arguments.maxresults;
		}
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " STATUS LIKE '%#arguments.q#%'", "|");
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
		hqlString = hqlString & "FROM orderstatus";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " STATUS LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
		return ormExecuteQuery(hqlString, false, params)[1];
	}
}