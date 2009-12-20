
/**
 * SECTION:ianjuta-editor-view
 * @title: IAnjutaEditorView
 * @short_description: Text editor view interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * An editor view is a visual representation of the editor. An editor
 * can have multiple views. All views of an editor show the same editor
 * content (buffer). Consequently, any change done in one view is
 * updated in all other views.
 */
public interface IAnjuta.EditorView : Editor
{
	/**
	 * ianjuta_editor_view_create:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Creates a new view for the editor. The newly created view gets
	 * the user focus and scrolls to the same location as last view.
	 */
	public abstract void create () throws Error;

	/**
	 * ianjuta_editor_view_remove_current:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Removes currently focused editor view. It does not remove the
	 * last view of the editor. That is, if currently there is only
	 * one view of the editor, this function does nothing.
	 */
	public abstract void remove_current () throws Error;

	/**
	 * ianjuta_editor_view_get_count:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Total number of views currently present. It will never be less
	 * than 1. Invalid return values are considered error condition.
	 */
	public abstract int get_count () throws Error;
}
