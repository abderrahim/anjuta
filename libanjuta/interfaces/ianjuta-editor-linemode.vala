/**
 * SECTION:ianjuta-editor-line-mode
 * @title: IAnjutaEditorLineMode
 * @short_description: Text editor line mode
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */

/**
 * IAnjutaEditorLineModeType:
 * @IANJUTA_EDITOR_LINE_MODE_LF: Line-Feed (Unix)
 * @IANJUTA_EDITOR_LINE_MODE_CR: Carat return (Max)
 * @IANJUTA_EDITOR_LINE_MODE_CRLF: Caret return + line-feed (Windows)
 *
 * This enumeration is used to specify the type of text. Note that not all
 * editors implement this.
 */
[CCode (cprefix="IANJUTA_EDITOR_LINE_MODE_")]
public enum IAnjuta.EditorLineModeType
{
	LF,
	CR,
	CRLF
}

public interface IAnjuta.EditorLineMode : Editor
{

	/**
	 * ianjuta_editor_line_mode_get:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Get current line ending mode. It is auto-detected from the
	 * buffer contents.
	 */
	public abstract EditorLineModeType @get () throws Error;

	/**
	 * ianjuta_editor_line_mode_set:
	 * @self: Self
	 * @mode: Line mode to set.
	 * @error: Error propagation and reporting
	 *
	 * Set the line ending mode to the given @mode. Existing line end
	 * characters in the buffer are not touched. Only the newly added
	 * texts will have @mode line end characters.
	 */
	public abstract void @set (EditorLineModeType mode) throws Error;

	/**
	 * ianjuta_editor_line_mode_convert:
	 * @self: Self
	 * @mode: Line mode to convert.
	 * @error: Error propagation and reporting
	 *
	 * Set the line ending mode to the given @mode and convert all line end
	 * characters in the buffer to @mode line end characters.
	 */
	public abstract void convert (EditorLineModeType mode) throws Error;

	/**
	 * ianjuta_editor_line_mode_fix:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Convert EOL characters to majority of line mode. This is helpful
	 * when the buffer contains mixed line modes and we want to fix it.
	 */
	public abstract void fix () throws Error;
}
