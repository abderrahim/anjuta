
/**
 * SECTION:ianjuta-editor-convert
 * @title: IAnjutaEditorConvert
 * @short_description: Text editor convert interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.EditorConvert : Editor
{
	/**
	 * ianjuta_editor_convert_to_upper:
	 * @self: Self
	 * @start_position: Start position.
	 * @end_position: End position.
	 * @error: Error propagation and reporting
	 *
	 * change characters from start position to end position to uppercase.
	 *
	 */
	public abstract void to_upper (Iterable start_position, Iterable end_position) throws Error;

	/**
	 * ianjuta_editor_convert_to_lower:
	 * @self: Self
	 * @start_position: Start position.
	 * @end_position: End position.
	 * @error: Error propagation and reporting
	 *
	 * change characters from start position to end position to lowercase
	 *
	 */
	public abstract void to_lower (Iterable start_position, Iterable end_position) throws Error;
}
