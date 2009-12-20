/**
 * SECTION:ianjuta-markable
 * @title: IAnjutaMarkable
 * @short_description: Implemented by editors (or views) with markers support
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
[CCode (cprefix="IANJUTA_MARKABLE_")]
public errordomain IAnjuta.MarkableError
{
	INVALID_LOCATION
}

/**
 * IAnjutaMarkableMarker:
 * @IANJUTA_MARKABLE_LINEMARKER: Mark a particular line
 * @IANJUTA_MARKABLE_BOOKMARK: A bookmark
 * @IANJUTA_MARKABLE_BREAKPOINT_DISABLED: a disabled breakpoint
 * @IANJUTA_MARKABLE_BREAKPOINT_ENABLED: a enabled breakpoint
 * @IANJUTA_MARKABLE_PROGRAM_COUNTER: Marks the program counter position
 *
 * This enumeration is used to specify the pixmap used for the marker
 */
[CCode (cprefix="IANJUTA_MARKABLE_")]
public enum IAnjuta.MarkableMarker
{
	LINEMARKER,
	BOOKMARK,
	BREAKPOINT_DISABLED,
	BREAKPOINT_ENABLED,
	PROGRAM_COUNTER
}

public interface IAnjuta.Markable : Object
{
	/**
	 * IAnjutaMarkable::marker-clicked:
	 * @self: Self
	 * @double_click: whether the marker was double clicked
	 * @location: location of the clicked marker
	 *
	 * The signal is emitted when the user clicks on a marker
	 */
	public virtual signal void marker_clicked (bool double_click, int location);

	/**
	 * ianjuta_markable_mark:
	 * @self: Self
	 * @location: Location at which the marker to set.
	 * @marker: Type of marker to be used
	 * @error: Error propagation and reporting
	 *
	 * Marks the specified location with the given marker type. Location is
	 * implementation depenedent. For example, for an editor location means
	 * lines where markers are set.
	 *
	 * Return value: Handle of the location marked. Can be used later to obtain
	 * new location, if it has been moved due to addetions/deletions in the
	 * implementor object.
	 */
	public abstract int mark (int location, MarkableMarker marker) throws Error;

	/**
	 * ianjuta_markable_location_from_handle:
	 * @self: Self
	 * @handle: Handle of location.
	 * @error: Error propagation and reporting
	 *
	 * Location where a marker is set could have moved by some operation in
	 * the implementation. To retrieve the correct location where the marker
	 * has moved, pass the handle retured by ianjuta_markable_mark() to this
	 * method.
	 *
	 * Return value: Current location where the marker was set.
	 */
	public abstract int location_from_handle (int handle) throws Error;

	/**
	* ianjuta_markable_unmark:
	* @self: Self
	* @location: Location where the marker is set.
	* @marker: The marker to unset.
	* @error: Error propagation and reporting
	*
	* Clears the @marker at given @location.
	*/
	public abstract void unmark (int location, MarkableMarker marker) throws Error;

	/**
	* ianjuta_markable_is_marker_set:
	* @self: Self
	* @location: Location to check.
	* @marker: Marker to check.
	* @error: Error propagation and reporting
	*
	* Check if the @marker is set at the given @location.
	*
	* Returns: TRUE if the marker is set at the location, other false.
	*/
	public abstract bool is_marker_set (int location, MarkableMarker marker) throws Error;

	/**
	* ianjuta_markable_delete_all_markers:
	* @self: Self
	* @marker: Marker to delete.
	* @error: Error propagation and reporting
	*
	* Delete the @marker from all locations.
	*/
	public abstract void delete_all_markers (MarkableMarker marker) throws Error;
}
