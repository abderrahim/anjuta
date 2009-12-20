
/**
 * SECTION:ianjuta-editor-folds
 * @title: IAnjutaEditorFolds
 * @short_description: Text editor folds inteface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.EditorFolds : Editor
{
	/**
	 * ianjuta_editor_view_open_folds:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Open all folds
	 *
	 */
	public abstract void open_all () throws Error;

	/**
	 * ianjuta_editor_view_close_folds:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Close all folds
	 *
	 */
	public abstract void close_all () throws Error;

	/**
	 * ianjuta_editor_view_toggle_fold:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Open/Close current fold
	 *
	 */
	public abstract void toggle_current () throws Error;
}
