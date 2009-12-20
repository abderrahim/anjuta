/**
 * SECTION:ianjuta-file-loader
 * @title: IAnjutaFileLoader
 * @short_description: Loader to load files
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * Loaders can deterime correct plugin to open a file.
 */
public interface IAnjuta.FileLoader : Loader
{
	/**
	 * ianjuta_file_loader_load:
	 * @self: Self
	 * @file: File to load
	 * @readonly: Open in readonly mode.
	 * @error: Error propagation and reporting
	 *
	 * Determines a plugin which can open the given file, activates it
	 * opening the file and returns the interface of the plugin activated.
	 *
	 * Return value: Plugin interface used to load the file.
	 */
	public abstract Object load (GLib.File file, bool readonly) throws Error;

	/**
	 * ianjuta_loader_peek_interface:
	 * @self: Self
	 * @file: Meta file to peek
	 * @error: Error propagation and reporting
	 *
	 * Peeks the file and determines the interface which can load
	 * this file.
	 *
	 * Return value: Plugin interface name that can load the file.
	 */
	public abstract string peek_interface (GLib.File file) throws Error;
}
