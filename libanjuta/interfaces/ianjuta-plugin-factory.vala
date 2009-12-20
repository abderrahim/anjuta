/**
 * SECTION:ianjuta-plugin-factory
 * @title: IAnjutaPluginFactory
 * @short_description: Create Anjuta plugin objects
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * This interface is used to create all Anjuta plugin objects. It is
 * already implemented inside Anjuta by an object able to load plugins written
 * in C. In order to load plugins in other languages (or in a different way),
 * a loader plugin implementing this interface must be written first, probably
 * in C.
 */

/**
 * IAnjutaPluginFactoryError:
 * @IANJUTA_PLUGIN_FACTORY_MISSING_LOCATION: Module file location is
 *	missing in .plugin file
 * @IANJUTA_PLUGIN_FACTORY_MISSING_TYPE: Plugin type (just after
 *	double colon following location) is missing in .plugin file
 * @IANJUTA_PLUGIN_FACTORY_MISSING_MODULE: Module file name not found,
 *	plugin module is probably not installed
 * @IANJUTA_PLUGIN_FACTORY_INVALID_MODULE: Module file cannot be
 *	loaded, not a shared library perhaps
 * @IANJUTA_PLUGIN_FACTORY_MISSING_FUNCTION: Module does not contain
 *	registration function, library is not an anjuta plugin or
 *	is not for the right version
 * @IANJUTA_PLUGIN_FACTORY_INVALID_TYPE: Module has not registered
 * 	plugin type, library is not an anjuta plugin or not for
 *	the right version
 * @IANJUTA_PLUGIN_FACTORY_UNKNOWN_ERROR: Another error
 *
 * These enumeration is used to specify errors.
 */
[CCode (cprefix="IANJUTA_PLUGIN_FACTORY_")]
public errordomain IAnjuta.PluginFactoryError
{
	OK = 0,
	MISSING_LOCATION,
	MISSING_TYPE,
	MISSING_MODULE,
	INVALID_MODULE,
	MISSING_FUNCTION,
	INVALID_TYPE,
	UNKNOWN_ERROR,
}

public interface IAnjuta.PluginFactory : Object
{
	/**
	 * ianjuta_plugin_factory_new_plugin:
	 * @self: Self
	 * @handle: Plugin information
	 * @shell: Anjuta shell
	 * @error: Error propagation and reporting.
	 *
	 * Create a new AnjutaPlugin object from the plugin information handle,
	 * give it the AnjutaShell object as argument.
	 *
	 * Return value: a new plugin object
	 */
	public abstract Anjuta.Plugin new_plugin (Anjuta.PluginHandle handle, Anjuta.Shell shell) throws Error;
}
