/**
 * SECTION:ianjuta-editor-hover
 * @title: IAnjutaEditorHover
 * @short_description: Text editor hover interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.hover
 *
 */
public interface IAnjuta.EditorHover : Editor
{
	/* IAnjutaEditorHover::hover-over:
	 * @self: self
	 * @position: IAnjutaEditorCell specifying the position the mouse is over
	 *
	 * The mouse is held for a moment over @position. This can be used to show
	 * all tooltip.
	 */
	public virtual signal void hover_over (Object position);

	/* IAnjutaEditorHover::hover-leave
	 * @self: self
	 * @position: IAnjutaEditorCell specifying the position the mouse was over
	 *
	 * User moved the mouse away - can be used to clean up things done in
	 * #IAnjutaEditorHover::hover-over
	 */
	public virtual signal void hover_leave (Object position);

	/**
	 * ianjuta_editor_hover_display:
	 * @self: Self
	 * @info: String to display
	 * @error: Error propagation and reporting
	 *
     * Show @info as tooltip
	 *
	 */
	public abstract void display (Iterable position, string info) throws Error;
}
