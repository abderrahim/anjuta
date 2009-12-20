/**
 * SECTION:ianjuta-editor-cell-style
 * @title: IAnjutaEditorCellStyle
 * @short_description: Text editor cell style interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.EditorCellStyle : EditorCell
{
	public abstract string get_font_description () throws Error;
	public abstract string get_color() throws Error;
	public abstract string get_background_color() throws Error;
}
