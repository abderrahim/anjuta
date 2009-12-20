/**
 * SECTION:ianjuta-editor-cell
 * @title: IAnjutaEditorCell
 * @short_description: Text editor character cell
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * Represents a cell in editor. A cell corresponds to a unicode
 * character along with all associated styles (such as colors and font).
 * A cell may or may not have style. If style is supported in the
 * editor, it is assumed all cells will have styles and hence every
 * IAnjutaEditorCell interface instance will have additionally
 * IAnjutaEditorCellStyle implemented.
 */
public interface IAnjuta.EditorCell : Object
{
	/**
	 * ianjuta_editor_cell_get_character:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Returns the unicode character in this cell. A NULL terminated
	 * string is returned that is the multibyte unicode character.
	 * NULL is returned if the cell does not have any character.
	 *
	 * Returns: a newly created string representing the cell's unicode
	 * character.
	 */
	public abstract string? get_character () throws Error;

	/**
	 * ianjuta_editor_cell_get_length:
	 * @self: self
	 * @error: Error propagation and reporting.
	 *
	 * Gets the length of the cell in bytes. That is, length of the
	 * unicode character.
	 *
	 * Returns: Length of the unicode character.
	 */
	public abstract int get_length () throws Error;

	/**
	 * ianjuta_editor_cell_get_char:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Returns the byte of the unicode character in this cell at given
	 * index @char_index. @char_index can vary from 0 to length of the
	 * unicode string minus 1. Out of range index is not allowed
	 * (asserted) and return is undefined.
	 *
	 * Since there is dynamic allocation of unicode character string
	 * involved in ianjuta_editor_cell_get_character(), this function
	 * is mainly useful for fast iteration (such as copying data).
	 *
	 * Returns: a byte character.
	 */
	public abstract char get_char (int char_index) throws Error;

	public abstract EditorAttribute get_attribute () throws Error;
}
