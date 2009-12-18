
/**
 * SECTION:ianjuta-file-manager
 * @title: IAnjutaFileManager
 * @short_description: File manager plugin
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.FileManager : Object
{
	/**
	 * IANJUTA_FILE_MANAGER_SELECTED_FILE
	 *
	 * Anjuta shell value set by file manager to the selected file.
	 */
	public const string SELECTED_FILE = "file_manager_selected_file";

	/**
	 * IAnjutaFileManager::section-changed:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public signal void section_changed (GLib.File file);

	/**
	 * ianjuta_file_manager_set_root:
	 * @self: Self
	 * @root_uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public abstract void set_root (string root_uri) throws Error;

	/**
	 * ianjuta_file_manager_get_selected:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public abstract GLib.File get_selected () throws Error;

	/**
	 * ianjuta_file_manager_set_selected:
	 * @self: Self
	 * @file: File to select
	 * @error: Error propagation and reporting.
	 *
	 * fixme.
	 */
	public abstract void set_selected (GLib.File file) throws Error;
}
