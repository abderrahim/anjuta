/**
 * SECTION:ianjuta-file-savable
 * @title: IAnjutaFileSavable
 * @short_description: Implemented by plugins that can save files.
 * @see_also: #IAnjutaFile
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * Plugins implementing #IAnjutaFile inteface that can also save files
 * should also implement this interface.
 */
public interface IAnjuta.FileSavable : IAnjuta.File
{
	/**
	 * IAnjutaFileSavable::update_save_ui:
	 * @self: Self
	 *
	 * This signal is emitted when the state of the file has
	 * changed. It could be that the user writes in it
	 * and the file becomes dirty or the opposite: after using
	 * undo, the file is back to its saved content. It is triggered
	 * if the file becomes read-only or give a conflict too.
	 */
	public virtual signal void update_save_ui ();

	/**
	 * IAnjutaFileSavable::saved:
	 * @self: Self
	 * @file: file where the content is saved or NULL if save failed
	 *
	 * This signal is emitted when the content is saved.
	 */
	public virtual signal void saved (GLib.File? file);

	/**
	 * ianjuta_file_savable_save:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Saves the content to the original file from which it was loaded.
	 * The signal saved is always emitted even if the save fails.
	 */
	public abstract void save () throws Error;

	/**
	 * ianjuta_file_savable_save_as:
	 * @self: Self
	 * @file: File to save the content.
	 * @error: Error propagation and reporting
	 *
	 * Saves the content to a different File.
	 * The signal saved is always emitted even if the save fails.
	 */
	public abstract void save_as (GLib.File file) throws Error;

	/**
	 * ianjuta_file_savable_set_dirty:
	 * @self: Self
	 * @dirty:
	 * @error: Error propagation and reporting
	 *
	 * if @dirty is TRUE, sets dirty for the content. Save point will be
	 * left and the content will be considered not saved. Otherwise,
	 * content will considered saved and save-point will be entered.
	 */
	public abstract void set_dirty (bool dirty) throws Error;

	/**
	 * ianjuta_file_savable_is_dirty:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Returns the dirty status of the content.
	 *
	 * Return value: TRUE if dirty, FALSE otherwise.
	 */
	public abstract bool is_dirty () throws Error;

	/**
	 * ianjuta_file_savable_is_read_only:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Return is the file is read-only
	 *
	 * Return value: TRUE if read-only, FALSE otherwise.
	 */
	public abstract bool is_read_only () throws Error;

	/**
	 * ianjuta_file_savable_is_conflict:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Return is the file is in conflict. It means the file
	 * has been modified externally and the user needs to
	 * tell which version he wants to use.
	 *
	 * Return value: TRUE if conflict, FALSE otherwise.
	 */
	public abstract bool is_conflict () throws Error;
}
