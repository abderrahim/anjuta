/**
 * SECTION:ianjuta-iterable
 * @title: IAnjutaIterable
 * @short_description: Implemented by objects that can iterate
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.Iterable : Object
{
	/**
	 * ianjuta_iterable_first:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Set iter to first element position. Returns FALSE if
	 * there is no element in the iterable (hence does not have first).
	 * The iter points to the first valid item.
	 *
	 * Returns: TRUE if sucessful, other FALSE.
	 */
	public abstract bool first () throws Error;

	/**
	 * ianjuta_iterable_next:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Set the iter position to next element position. Iter can go until one
	 * item past the last item and lands in end-iter. end-iter does not point
	 * to any valid item and signifies end of the list. Returns FALSE if iter
	 * was already at end-iter (iter can not go past it) and remains pointed
	 * to the end-iter.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE if already at end-iter.
	 */
	public abstract bool next () throws Error;

	/**
	 * ianjuta_iterable_previous:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Set the iter position to previous element position. Returns FALSE if
	 * there is no previous element and the iter remains pointed to the first
	 * element.
	 *
	 * Returns: TRUE if sucessful, other FALSE.
	 */
	public abstract bool previous () throws Error;

	/**
	 * ianjuta_iterable_last:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Set iter position to end-iter (one past last element) position.
	 * Returns FALSE if there is no element in the iterable (already
	 * at end-iter).
	 *
	 * Returns: TRUE if sucessful, other FALSE.
	 */
	public abstract bool last () throws Error;

	/**
	 * ianjuta_iterable_foreach:
	 * @self: Self
	 * @callback: Callback to call for each element.
	 * @user_data: user data that is passed back to the callback.
	 * @error: Error propagation and reporting
	 *
	 * Call callback for each element in the list. Call back is passed the
	 * same iter, but with different position set (from first to last). This
	 * method does not affect current position. i.e. current position is
	 * restored at the end of this method.
	 */
	public abstract void @foreach (Func callback) throws Error;

	/**
	 * ianjuta_iterable_set_position:
	 * @self: Self
	 * @position: New position for the iter.
	 * @error: Error propagation and reporting
	 *
	 * Sets the current position of the iter to @position. The given @position
	 * must be from 0 to length - 1 (#ianjuta_iter_get_length()) to point to
	 * a valid element. Passing @position < 0 will set it to end-iter. It
	 * returns TRUE for the above cases. FLASE will be returned, if
	 * out-of-range @position is passed (@position > length - 1) and iter is
	 * set to end-iter.
	 *
	 * Returns: TRUE if successfully set (i.e. @position is within the range or
	 * end-iter). otherwise returns FALSE (i.e. @position is out of data range).
	 */
	public abstract bool set_position (int position) throws Error;

	/**
	 * ianjuta_iterable_get_position:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Index of the current iter in the iterable. It will be
	 * from 0 to length - 1 (ianjuta_iter_get_length()) if iter is pointed
	 * at valid element. It will return -1 if iter is pointed at end-iter.
	 *
	 * Returns: integer index, or -1 for end-iter.
	 */
	public abstract int get_position () throws Error;

	/**
	 * ianjuta_iterable_get_length:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Length of the iterable (number of elements indexable by it).
	 *
	 * Returns: total length of the list.
	 */
	public abstract int get_length () throws Error;

	/**
	 * ianjuta_iterable_clone:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Clones the iterable. The returned iterable object must be unreffed
	 * when done.
	 *
	 * Returns: A new instance of this iterable pointing at the same location.
	 */
	public abstract Iterable clone () throws Error;

	/**
	 * ianjuta_iterable_assign:
	 * @self: Self
	 * @src_iter: Source iter from which to copy the assignment.
	 * @error: Error propagation and reporting
	 *
	 * Assigns the iter position from @src_iter.
	 *
	 */
	public abstract void assign (Iterable src_iter) throws Error;

	/**
	 * ianjuta_iterable_compare:
	 * @self: Self
	 * @iter2: Second iter to compare.
	 * @error: Error propagation and reporting
	 *
	 * Compares the position of @iter2 with this @obj. Returns -1
	 * value if this @obj is smaller than @iter2. Returns +1 value
	 * if this @obj is larger than @iter2. And returns 0 if both are equal.
	 * If you want difference of the iter positions, use
	 * #ianjuta_iterable_diff(). This method is meant for fast comparision.
	 *
	 * Returns: 0 if equal, -1 if @obj is smaller than @iter2
	 * or +1 if @obj is larger than @iter2.
	 *
	 */
	public abstract int compare (Iterable iter2) throws Error;

	/**
	 * ianjuta_iterable_diff:
	 * @self: Self
	 * @iter2: Second iter to differenciate.
	 * @error: Error propagation and reporting
	 *
	 * Compares the position of @iter2 with this @obj and returns difference
	 * in position of the two (@obj - @iter2).
	 *
	 * Returns: The position difference of @obj - @iter2
	 *
	 */
	public abstract int diff (Iterable iter2) throws Error;
}
