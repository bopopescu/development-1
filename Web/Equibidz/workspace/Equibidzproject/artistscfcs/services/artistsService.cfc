/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component{


	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public artistsService function init() {
		This.table = "ARTISTS";
		return This;
	}

	/**
	* @hint Returns the count of records in artists
	*/
	public numeric function count() {
		return ormExecuteQuery("select Count(*) from artists")[1];
	}

	/**
	* @hint Returns all of the records in artists.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.artists[] function list() {
		return entityLoad("artists", {}, "ARTISTID asc");
	}

	/**
	* @hint Returns all of the records in artists, with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.artists[] function listPaged(numeric offset ="0" , numeric maxresults ="0" , string orderby ="ARTISTID asc" ) {
		var loadArgs = {};
		if (arguments.offset neq 0){
			loadArgs.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			loadArgs.maxresults = arguments.maxresults;
		}
		return entityLoad("artists", {}, arguments.orderby, loadArgs);
	}

	/**
	* @hint Returns one record from artists.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.artists function get(required numeric id ) {
		return EntityLoad("artists", arguments.id, true);
	}

	/**
	* @hint Updates one record from artists.
	*/
	public void function update(required any artists ) {
		arguments.artists.nullifyZeroID();
		EntitySave(arguments.artists);
	}

	/**
	* @hint Deletes one record from artists.
	*/
	public void function destroy(required any artists ) {
		EntityDelete(arguments.artists);
	}

	/**
	* @hint Performs search against artists.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.artists[] function search(string q ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM artists";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " FIRSTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " LASTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " ADDRESS LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " CITY LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " STATE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " POSTALCODE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " EMAIL LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " PHONE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " FAX LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " THEPASSWORD LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
			hqlString = hqlString & " ORDER BY ARTISTID asc";
		return ormExecuteQuery(hqlString, false, params);
	}

	/**
	* @hint Performs search against artists., with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.artists[] function searchPaged(string q , numeric offset ="0" , numeric maxresults ="0" , string orderby ="ARTISTID asc" ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM artists";
		if (arguments.offset neq 0){
			params.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			params.maxresults = arguments.maxresults;
		}
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " FIRSTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " LASTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " ADDRESS LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " CITY LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " STATE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " POSTALCODE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " EMAIL LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " PHONE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " FAX LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " THEPASSWORD LIKE '%#arguments.q#%'", "|");
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
		hqlString = hqlString & "FROM artists";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " FIRSTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " LASTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " ADDRESS LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " CITY LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " STATE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " POSTALCODE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " EMAIL LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " PHONE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " FAX LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " THEPASSWORD LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
		return ormExecuteQuery(hqlString, false, params)[1];
	}
}