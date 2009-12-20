
/**
 * SECTION:ianjuta-editor-zoom
 * @title: IAnjutaEditorZoom
 * @short_description: Text editor zoom interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.EditorZoom : Editor
{
	/**
	 * ianjuta_editor_zoom_in:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Zoom in
	 */
	public abstract void @in () throws Error;

	/**
	 * ianjuta_editor_zoom_out:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Zoom out
	 */
	public abstract void @out () throws Error;
}
