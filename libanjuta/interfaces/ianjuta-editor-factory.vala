/**
 * SECTION:ianjuta-editor-factory
 * @title: IAnjutaEditorFactory
 * @short_description: Text editor factory that creates IAnjutaEditor objects
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.EditorFactory : Object
{
	/**
	 * ianjuta_editor_factory_new_editor:
	 * @self: Self
	 * @file: file to open
	 * @filename: filename to open
	 * @error: Error propagation and reporting
	 *
	 * Get a new GtkWidget* which implements IAnjutaEditor
	 *
	 * Return value: An object implementing IAnjutaEditor
	 */
	public abstract Editor new_editor (GLib.File file, string filename) throws Error;
}
