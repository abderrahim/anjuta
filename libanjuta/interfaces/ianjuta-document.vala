/**
 * SECTION:ianjuta-document
 * @title: IAnjutaDocument
 * @short_description: Interface for all kind of editable resources that
 * will be managed by IAnjutaDocumentManager
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.Document : Object
{
	/**
	 * IAnjutaDocument::update-ui:
	 * @self: Self
	 *
	 * This signal is emitted when the document assumes the UI must be updated
	 * because some internal state of the document has changed. For example, if
	 * current line position is changed, it needs to be reflected to the UI.
	 */
	public virtual signal void update_ui ();

	/**
	 * ianjuta_document_get_filename:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Allows obtaining of the filename the editor was loaded from.
	 *
	 * Return value: The name of the file. Not to be freed by caller.
	 */
	public abstract unowned string get_filename () throws Error;

	/**
	 * ianjuta_document_can_undo:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Can the editor undo the last operation?
	 *
	 * Returns: TRUE if editor can undo, else FALSE
	 */
	public abstract bool can_undo() throws Error;

	/**
	 * ianjuta_document_can_redo:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Can the editor redo the last operation?
	 *
	 * Returns: TRUE if editor can redo, else FALSE
	 */
	public abstract bool can_redo () throws Error;

	/**
	 * ianjuta_document_undo:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Undo last operation
	 */
	public abstract void undo () throws Error;

	/**
	 * ianjuta_document_redo:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Redo last undo operation
	 */
	public abstract void redo () throws Error;

	/**
	 * ianjuta_document_begin_undo_action:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Begins the mark of undoable action. Calls to this are stacked and
	 * each must be ended with ianjuta_document_end_action().
	 */
	public abstract void begin_undo_action () throws Error;

	/**
	 * ianjuta_document_end_undo_action:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Ends the mark of undoable action.
	 */
	public abstract void end_undo_action () throws Error;

	/**
	 * ianjuta_document_grab_focus:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Grabs the focus.
	 */
	public abstract void grab_focus () throws Error;

	/**
	 * ianjuta_document_cut:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Cut selection to clipboard.
	 */
	public abstract void cut () throws Error;

	/**
	 * ianjuta_document_copy:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Copy selection to clipboard.
	 */
	public abstract void copy () throws Error;

	/**
	 * ianjuta_document_paste:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Paste clipboard at current position.
	 */
	public abstract void paste () throws Error;

	/**
	 * ianjuta_document_clear:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Clear selection
	 */
	public abstract void clear () throws Error;
}
