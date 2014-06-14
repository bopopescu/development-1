/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component{


	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public artService function init() {
		This.table = "ART";
		return This;
	}

	/**
	* @hint Returns the count of records in art
	*/
	public numeric function count() {
		return ormExecuteQuery("select Count(*) from art")[1];
	}

	/**
	* @hint Returns all of the records in art.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.art[] function list() {
		return entityLoad("art", {}, "ARTID asc");
	}

	/**
	* @hint Returns all of the records in art, with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.art[] function listPaged(numeric offset ="0" , numeric maxresults ="0" , string orderby ="ARTID asc" ) {
		var loadArgs = {};
		if (arguments.offset neq 0){
			loadArgs.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			loadArgs.maxresults = arguments.maxresults;
		}
		return entityLoad("art", {}, arguments.orderby, loadArgs);
	}

	/**
	* @hint Returns one record from art.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.art function get(required numeric id ) {
		return EntityLoad("art", arguments.id, true);
	}

	/**
	* @hint Updates one record from art.
	*/
	public void function update(required any art ) {
		arguments.art.nullifyZeroID();
		EntitySave(arguments.art);
	}

	/**
	* @hint Deletes one record from art.
	*/
	public void function destroy(required any art ) {
		EntityDelete(arguments.art);
	}

	/**
	* @hint Performs search against art.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.art[] function search(string q ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM art";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " ARTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " LARGEIMAGE LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
			hqlString = hqlString & " ORDER BY ARTID asc";
		return ormExecuteQuery(hqlString, false, params);
	}

	/**
	* @hint Performs search against art., with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.art[] function searchPaged(string q , numeric offset ="0" , numeric maxresults ="0" , string orderby ="ARTID asc" ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM art";
		if (arguments.offset neq 0){
			params.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			params.maxresults = arguments.maxresults;
		}
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " ARTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " LARGEIMAGE LIKE '%#arguments.q#%'", "|");
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
		hqlString = hqlString & "FROM art";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " ARTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " LARGEIMAGE LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
		return ormExecuteQuery(hqlString, false, params)[1];
	}
}