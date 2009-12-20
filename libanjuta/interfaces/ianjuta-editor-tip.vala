/**
 * SECTION:ianjuta-editor-tip
 * @title: IAnjutaEditorTip
 * @short_description: Editor call tips assistance framework
 * @see_also: 
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.EditorTip : Editor
{
	/**
	 * ianjuta_editor_tip_show:
	 * @self: Self
	 * @tips: list of alternative tips.
	 * @char_alignment: Character alignment.
	 * @error: Error propagation and reporting
	 *
	 * Show tips showing more information on current context. No user feedback
	 * is required when tips are shown. @char_alignment indicates
	 * the position before which is the known context and after which are
	 * the suggestions. Usually the editor would use this to
	 * align the choices displayed such that the carat is just at this
	 * position when the choices are displayed.
	 *
	 */
	public abstract void show (List<string> tips, Iterable position, int char_alignment) throws Error;

	/**
	 * ianjuta_editor_tip_cancel
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Cancels the last shown tooltip
	 */
	public abstract void cancel () throws Error;

	/**
	 * ianjuta_editor_tip_visible:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Returns: whether a tooltip is crrently shown
	 */
	public abstract bool visible() throws Error;
}
