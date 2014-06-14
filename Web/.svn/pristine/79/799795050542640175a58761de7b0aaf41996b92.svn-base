component implements="CFIDE.ORM.IEventHandler"{


	/**
	* @hint Event handler that fires after a delete operation.
	*/
	public void function postDelete(any entity ) {
	}

	/**
	* @hint Event handler that fires after a insert operation.
	*/
	public void function postInsert(any entity ) {
	}

	/**
	* @hint Event handler that fires after a load operation.
	*/
	public void function postLoad(any entity ) {
	}

	/**
	* @hint Event handler that fires after a update operation.
	*/
	public void function postUpdate(any entity ) {
	}

	/**
	* @hint Event handler that fires before a delete operation.
	*/
	public void function preDelete(any entity ) {
	}

	/**
	* @hint Event handler that fires before an insert operation. Ensures magic words get populated.
	*/
	public void function preInsert(any entity ) {
		if (structKeyExists(entity, "setcreatedOn")){
			entity.setcreatedOn(now());
		}

		if (structKeyExists(entity, "setupdatedOn")){
			entity.setupdatedOn(now());
		}
	}

	/**
	* @hint Event handler that fires before a load operation.
	*/
	public void function preLoad(any entity ) {
	}

	/**
	* @hint Event handler that fires before a update operation. Ensures magic words get populated.
	*/
	public void function preUpdate(any entity , struct oldData ) {
		if (structKeyExists(entity, "setupdatedOn")){
			entity.setupdatedOn(now());
		}
	}
}