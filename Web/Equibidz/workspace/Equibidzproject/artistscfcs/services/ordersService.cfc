/* NOTE: Any changes you make to this CFC will be written over if you regenerate the application.*/
component{


	/**
	* @hint A initialization routine, runs when object is created.
	*/
	public ordersService function init() {
		This.table = "ORDERS";
		return This;
	}

	/**
	* @hint Returns the count of records in orders
	*/
	public numeric function count() {
		return ormExecuteQuery("select Count(*) from orders")[1];
	}

	/**
	* @hint Returns all of the records in orders.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orders[] function list() {
		return entityLoad("orders", {}, "ORDERID asc");
	}

	/**
	* @hint Returns all of the records in orders, with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orders[] function listPaged(numeric offset ="0" , numeric maxresults ="0" , string orderby ="ORDERID asc" ) {
		var loadArgs = {};
		if (arguments.offset neq 0){
			loadArgs.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			loadArgs.maxresults = arguments.maxresults;
		}
		return entityLoad("orders", {}, arguments.orderby, loadArgs);
	}

	/**
	* @hint Returns one record from orders.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orders function get(required numeric id ) {
		return EntityLoad("orders", arguments.id, true);
	}

	/**
	* @hint Updates one record from orders.
	*/
	public void function update(required any orders ) {
		arguments.orders.nullifyZeroID();
		EntitySave(arguments.orders);
	}

	/**
	* @hint Deletes one record from orders.
	*/
	public void function destroy(required any orders ) {
		EntityDelete(arguments.orders);
	}

	/**
	* @hint Performs search against orders.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orders[] function search(string q ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM orders";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " CUSTOMERFIRSTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " CUSTOMERLASTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " ADDRESS LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " CITY LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " STATE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " POSTALCODE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " PHONE LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
			hqlString = hqlString & " ORDER BY ORDERID asc";
		return ormExecuteQuery(hqlString, false, params);
	}

	/**
	* @hint Performs search against orders., with paging.
	*/
	public C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.orders[] function searchPaged(string q , numeric offset ="0" , numeric maxresults ="0" , string orderby ="ORDERID asc" ) {

		var hqlString = "";
		var whereClause = "";
		var params = {};
		hqlString = hqlString & "FROM orders";
		if (arguments.offset neq 0){
			params.offset = arguments.offset;
		}
		if (arguments.maxresults neq 0){
			params.maxresults = arguments.maxresults;
		}
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " CUSTOMERFIRSTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " CUSTOMERLASTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " ADDRESS LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " CITY LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " STATE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " POSTALCODE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " PHONE LIKE '%#arguments.q#%'", "|");
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
		hqlString = hqlString & "FROM orders";
		if (len(arguments.q) gt 0){
			whereClause  = ListAppend(whereClause, " CUSTOMERFIRSTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " CUSTOMERLASTNAME LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " ADDRESS LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " CITY LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " STATE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " POSTALCODE LIKE '%#arguments.q#%'", "|");
			whereClause  = ListAppend(whereClause, " PHONE LIKE '%#arguments.q#%'", "|");
			whereClause = Replace(whereClause, "|", " OR ", "all");
		}
		if (len(whereClause) gt 0){
			hqlString = hqlString & " WHERE " & whereClause;
		}
		return ormExecuteQuery(hqlString, false, params)[1];
	}
}