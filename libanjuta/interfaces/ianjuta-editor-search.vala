/**
 * SECTION:ianjuta-editor-search
 * @title: IAnjutaEditorSearch
 * @short_description: Text editor search interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.EditorSearch : Editor
{
	/**
	 * ianjuta_editor_search_forward:
	 * @self: Self
	 * @search: String to search for
	 * @start: Where to search from
	 * @end: Where to stop searching
	 * @result_start: Will be set to the start of the search_result (or NULL)
	 * @result_end: Will be set to the end of the search_result (or NULL)
	 * @error: Error propagation and reporting
	 *
	 * Search forward from start to end
	 *
	 */
	public abstract bool forward (string search, bool case_sensitive, EditorCell start, EditorCell end, out EditorCell? result_start, out EditorCell? result_end) throws Error;

	/**
	 * ianjuta_editor_search_backward:
	 * @self: Self
	 * @search: String to search for
	 * @start: Where to search from
	 * @end: Where to stop searching
	 * @result_start: Will be set to the start of the search_result (or NULL)
	 * @result_end: Will be set to the end of the search_result (or NULL)
	 * @error: Error propagation and reporting
	 *
	 * Search backward from end to start
	 *
	 */
	public abstract bool backward (string search, bool case_sensitive, EditorCell start, EditorCell end, out EditorCell? result_start, out EditorCell? result_end) throws Error;
}
