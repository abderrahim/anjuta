/**
 * SECTION:ianjuta-file
 * @title: IAnjutaFile
 * @short_description: Implemented by plugins that can open files.
 * @see_also: #IAnjutaFileSavable
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * Any plugin that can open files should implemented this interface. Along
 * with the 'File Loader::SupportedMimeTypes' property of the plugin in
 * .plugin file, it will be used by the loader to open files of that type.
 */
public interface IAnjuta.File : Object
{
	/**
	 * ianjuta_file_open:
	 * @self: Self
	 * @file: file to open.
	 * @error: Error propagation and reporting
	 *
	 * The implementor opens the given file.
	 */
	public abstract void open (GLib.File file) throws Error;

	/**
	 * ianjuta_file_get_file:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Returns the file that was opened with ianjuta_file_open().
	 *
	 * Return value: The last file opened.
	 */
	public abstract GLib.File get_file () throws Error;
}
