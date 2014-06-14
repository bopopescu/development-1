/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component{


	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public galleryadminService function init() {
		This.table = "GALLERYADMIN";
		return This;
	}

	/**
	* @hint Returns the count of records in galleryadmin
	*/
	public numeric function count() {
		return ormExecuteQuery("select Count(*) from galleryadmin")[1];
	}

	/**
	* @hint Returns all of the records in galleryadmin.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.galleryadmin[] function list() {
		return entityLoad("galleryadmin", {}, "GALLERYADMINID asc");
	}

	/**
	* @hint Returns all of the records in galleryadmin, with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.galleryadmin[] function listPaged(numeric offset ="0" , numeric maxresults ="0" , string orderby ="GALLERYADMINID asc" ) {
		var loadArgs = {};
		if (arguments.offset neq 0){
			loadArgs.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			loadArgs.maxresults = arguments.maxresults;
		}
		return entityLoad("galleryadmin", {}, arguments.orderby, loadArgs);
	}

	/**
	* @hint Returns one record from galleryadmin.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.galleryadmin function get(required numeric id ) {
		return EntityLoad("galleryadmin", arguments.id, true);
	}

	/**
	* @hint Updates one record from galleryadmin.
	*/
	public void function update(required any galleryadmin ) {
		arguments.galleryadmin.nullifyZeroID();
		EntitySave(arguments.galleryadmin);
	}

	/**
	* @hint Deletes one record from galleryadmin.
	*/
	public void function destroy(required any galleryadmin ) {
		EntityDelete(arguments.galleryadmin);
	}

	/**
	* @hint Performs search against galleryadmin.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.galleryadmin[] function search(string q ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM galleryadmin";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " FIRSTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " LASTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " EMAIL LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " ADMINPASSWORD LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
			hqlString = hqlString & " ORDER BY GALLERYADMINID asc";
		return ormExecuteQuery(hqlString, false, params);
	}

	/**
	* @hint Performs search against galleryadmin., with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.galleryadmin[] function searchPaged(string q , numeric offset ="0" , numeric maxresults ="0" , string orderby ="GALLERYADMINID asc" ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM galleryadmin";
		if (arguments.offset neq 0){
			params.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			params.maxresults = arguments.maxresults;
		}
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " FIRSTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " LASTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " EMAIL LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " ADMINPASSWORD LIKE '%#arguments.q#%'", "|");
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
		hqlString = hqlString & "FROM galleryadmin";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " FIRSTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " LASTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " EMAIL LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " ADMINPASSWORD LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
		return ormExecuteQuery(hqlString, false, params)[1];
	}
}