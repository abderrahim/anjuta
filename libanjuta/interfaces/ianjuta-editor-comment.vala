
/**
 * SECTION:ianjuta-editor-comment
 * @title: IAnjutaEditorComment
 * @short_description: Text editor comment interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.EditorComment : Editor
{
	/**
	 * ianjuta_editor_comment_block:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Comment/Uncomment out selected block
	 */
	public abstract void block() throws Error;

	/**
	 * ianjuta_editor_comment_box:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Comment/Uncomment out selected block
	 */
	public abstract void box() throws Error;

	/**
	 * ianjuta_editor_comment_stream:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Comment/Uncomment out selected block
	 */
	public abstract void stream() throws Error;
}
