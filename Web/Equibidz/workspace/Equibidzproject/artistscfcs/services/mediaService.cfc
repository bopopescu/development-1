/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component{


	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public mediaService function init() {
		This.table = "MEDIA";
		return This;
	}

	/**
	* @hint Returns the count of records in media
	*/
	public numeric function count() {
		return ormExecuteQuery("select Count(*) from media")[1];
	}

	/**
	* @hint Returns all of the records in media.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.media[] function list() {
		return entityLoad("media", {}, "MEDIAID asc");
	}

	/**
	* @hint Returns all of the records in media, with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.media[] function listPaged(numeric offset ="0" , numeric maxresults ="0" , string orderby ="MEDIAID asc" ) {
		var loadArgs = {};
		if (arguments.offset neq 0){
			loadArgs.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			loadArgs.maxresults = arguments.maxresults;
		}
		return entityLoad("media", {}, arguments.orderby, loadArgs);
	}

	/**
	* @hint Returns one record from media.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.media function get(required numeric id ) {
		return EntityLoad("media", arguments.id, true);
	}

	/**
	* @hint Updates one record from media.
	*/
	public void function update(required any media ) {
		arguments.media.nullifyZeroID();
		EntitySave(arguments.media);
	}

	/**
	* @hint Deletes one record from media.
	*/
	public void function destroy(required any media ) {
		EntityDelete(arguments.media);
	}

	/**
	* @hint Performs search against media.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.media[] function search(string q ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM media";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " MEDIATYPE LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
			hqlString = hqlString & " ORDER BY MEDIAID asc";
		return ormExecuteQuery(hqlString, false, params);
	}

	/**
	* @hint Performs search against media., with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.media[] function searchPaged(string q , numeric offset ="0" , numeric maxresults ="0" , string orderby ="MEDIAID asc" ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM media";
		if (arguments.offset neq 0){
			params.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			params.maxresults = arguments.maxresults;
		}
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " MEDIATYPE LIKE '%#arguments.q#%'", "|");
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
		hqlString = hqlString & "FROM media";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " MEDIATYPE LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
		return ormExecuteQuery(hqlString, false, params)[1];
	}
}