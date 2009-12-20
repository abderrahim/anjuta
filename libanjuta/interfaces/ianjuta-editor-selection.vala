/**
 * SECTION:ianjuta-editor-selection
 * @title: IAnjutaEditorSelection
 * @short_description: Text editor selection interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.EditorSelection : Editor
{
	/**
	 * ianjuta_editor_selection_has_selection:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Returns TRUE if editor has any text selected. The selection
	 * positions can be retrieved with ianjuta_editor_selection_get_start()
	 * and ianjuta_editor_selection_get_end().
	 *
	 * Returns: TRUE if there is text selected else FALSE.
	 */
	public abstract bool has_selection () throws Error;

	/**
	 * ianjuta_editor_selection_get:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Gets curerntly selected text in editor.
	 *
	 * Returns: A newly allocated buffer of currently selected characters.
	 * NULL if there is no selection. The returned buffer must be freed after
	 * use.
	 */
	public abstract string? @get () throws Error;

	/**
	 * ianjuta_editor_selection_set:
	 * @self: Self
	 * @start: Begin of selection
	 * @end: End of selection
	 * @scroll: Scroll selection onscreen
	 * @error: Error propagation and reporting
	 *
	 * Select characters between start and end. Start and end don't have to
	 * be ordered.
	 */
	public abstract void @set (Iterable start, Iterable end, bool scroll) throws Error;

	/**
	 * ianjuta_editor_selection_get_start:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Gets start position of selection text.
	 *
	 * Return: Start of selection or NULL if there is no selection.
	 */
	public abstract Iterable? get_start () throws Error;

	/**
	 * ianjuta_editor_selection_get_end:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Get end position of selection. If there is no selection, returns
	 * NULL.
	 *
	 * Returns: End of selection or NULL if there is no selection.
	 */
	public abstract Iterable? get_end () throws Error;

	/**
	 * ianjuta_editor_selection_select_block:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Selects current block of code. The definition of block of code
	 * depends on highlight mode used (programming language). Some
	 * highlight mode does not have block concept, in that case this
	 * method does not do anything.
	 */
	public abstract void select_block () throws Error;

	/**
	 * ianjuta_editor_selection_select_function:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Select current function block. The definition of function block
	 * depends on highlight mode used (programming language). Some
	 * highlight mode does not have function concept, in that case this
	 * method does not do anything.
	 */
	public abstract void select_function () throws Error;

	/**
	 * ianjuta_editor_edit_select_all:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Select whole buffer.
	 */
	public abstract void select_all () throws Error;

	/**
	 * ianjuta_editor_selection_replace:
	 * @self: Self
	 * @text: Replacement text.
	 * @length: Length of the text to used in @text.
	 * @error: Error propagation and reporting
	 *
	 * Replaces currently selected text with the @text. Only @length amount
	 * of characters are used from @text buffer to replace.
	 */
	public abstract void replace (string text, int length) throws Error;
}
