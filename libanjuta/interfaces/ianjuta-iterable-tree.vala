/**
 * SECTION:ianjuta-iterable-tree
 * @title: IAnjutaIterableTree
 * @short_description: Implemented by tree objects that can iterate
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.IterableTree : Iterable
{
	/**
	 * ianjuta_iterable_tree_parent:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Set iter position to parent of curernt iter. If there is no parent,
	 * returns FALSE (current iter position is not changed)
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool parent () throws Error;

	/**
	 * ianjuta_iterable_tree_children:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Iter position set to first child of current iter. If there is no
	 * children, return NULL (iter position is not changed).
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool children () throws Error;

	/**
	 * ianjuta_iterable_tree_has_children:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Returns true if current iter has children
	 *
	 * Returns: TRUE if there are children, otherwise FALSE.
	 */
	public abstract bool has_children () throws Error;

	/**
	 * ianjuta_iterable_tree_foreach_post:
	 * @self: Self
	 * @callback: Callback to call for each element.
	 * @user_data: User data to pass back to callback.
	 * @error: Error propagation and reporting
	 *
	 * Call callback for each element in post order.
	 */
	public abstract void foreach_post (Func callback) throws Error;

	/**
	 * ianjuta_iterable_tree_foreach_pre:
	 * @self: Self
	 * @callback: Callback to call for each element.
	 * @user_data: User data to pass back to callback.
	 * @error: Error propagation and reporting
	 *
	 * Call callback for each element in pre order.
	 */
	public abstract void foreach_pre (Func callback) throws Error;
}
