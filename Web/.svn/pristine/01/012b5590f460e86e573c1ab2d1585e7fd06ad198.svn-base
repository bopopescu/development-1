component{

	This.name = "cfartgallery";
	This.ormenabled = true;
	This.datasource = "cfartgallery";
	This.customTagPaths = GetDirectoryFromPath(GetCurrentTemplatePath()) & "customtags";
	This.ormsettings.eventHandler = "C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.cfc.eventHandler";
	This.ormsettings.dbcreate = "update";
	This.ormsettings.logSQL = true;


	public boolean function onRequestStart() {

		if (structKeyExists(url, "reset_app")){
			ApplicationStop();
			location(cgi.script_name, false);
		}

		return true;
	}

	public boolean function onApplicationStart() {
		application.ordersService = new C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.services.ordersService();
		application.artistsService = new C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.services.artistsService();
		application.galleryadminService = new C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.services.galleryadminService();
		application.artService = new C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.services.artService();
		application.orderitemsService = new C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.services.orderitemsService();
		application.mediaService = new C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.services.mediaService();
		application.orderstatusService = new C:.Equibidz.Equibidzdev.workspace.Equibidzproject.artistscfcs.services.orderstatusService();
		return true;
	}
}