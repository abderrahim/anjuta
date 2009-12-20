
/**
 * SECTION:ianjuta-editor-goto
 * @title: IAnjutaEditorGoto
 * @short_description: Text editor navigation interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.EditorGoto : Editor
{
	/**
	 * ianjuta_editor_goto_start_block()
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Moves cursor to the start of the current block
	 */
	public abstract void start_block() throws Error;

	/**
	 * ianjuta_editor_goto_end_block()
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Moves cursor to the end of the current block
	 */
	public abstract void end_block() throws Error;

	/**
	 * ianjuta_editor_goto_matching_brace()
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Moves cursor to matching brace
	 */
	public abstract void matching_brace() throws Error;
}
