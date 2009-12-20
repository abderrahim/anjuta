/**
 * SECTION:ianjuta-message-manager
 * @title: IAnjutaMessageManager
 * @short_description: The plugin that managers all message views
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public errordomain IAnjuta.MessageManagerError
{
	DOESNT_EXIST
}

public interface IAnjuta.MessageManager : Object
{
	/**
	 * ianjuta_message_manager_add_view:
	 * @self: Self
	 * @name: Name/Title of the new view
	 * @icon: Path to an icon or ""
	 * @error: Error propagation and reporting
	 *
	 * Adds a new view to the message-manager
	 *
	 * Return value: The new message-view
	 */
	public abstract MessageView add_view (string name, string icon) throws Error;

	/**
	 * ianjuta_message_manager_remove_view:
	 * @self: Self
	 * @view: The view to remove
	 * @error: Error propagation and reporting
	 *
	 * Remove view from the message-manager. The view
	 * will become invalid.
	 */
	public abstract void remove_view (MessageView view) throws Error;

	/**
	 * ianjuta_message_manager_get_current_view:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Get the view with is currently on top of
	 * the notebook or NULL if the message-manager is empty.
	 *
	 * Return value: Current view; #IAnjutaMessageView object.
	 * NULL, if there is no views.
	 */
	public abstract MessageView? get_current_view () throws Error;

	/**
	 * ianjuta_message_manager_get_view_by_name:
	 * @self: Self
	 * @name: Name/Title of the view
	 * @error: Error propagation and reporting
	 *
	 * Get the view with the given name or NULL if
	 * it does not exist.
	 *
	 * Return value: The message-view or NULL
	 */
	public abstract MessageView? get_view_by_name (string name) throws Error;

	/**
	 * ianjuta_message_manager_get_all_views:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Get all message-views
	 *
	 * Return value: A GList* of all views. You must not
	 * manipulate the list.
	 */
	public abstract unowned List<MessageView> get_all_views () throws Error;

	/**
	 * ianjuta_message_manager_set_current_view:
	 * @self: Self
	 * @view: A message view
	 * @error: Error propagation and reporting
	 *
	 * Set view to be on top of the notebook.
	 *
	 */
	public abstract void set_current_view (MessageView view) throws Error;

	/**
	 * ianjuta_message_manager_set_view_title:
	 * @self: Self
	 * @view: A message view
	 * @title: Sets the title of view.
	 * @error: Error propagation and reporting
	 *
	 * Sets the title of view.
	 *
	 */
	public abstract void set_view_title (MessageView view, string title) throws Error;

	/**
	 * ianjuta_message_manager_set_view_icon:
	 * @self: Self
	 * @view: A message view
	 * @icon: Sets the icon of view.
	 * @error: Error propagation and reporting
	 *
	 * Sets the icon of view.
	 *
	 */
	public abstract void set_view_icon (MessageView view, Gdk.PixbufAnimation icon) throws Error;

	/**
	 * ianjuta_message_manager_set_view_icon_from_stock:
	 * @self: Self
	 * @view: A message view
	 * @icon: Sets the icon of view.
	 * @error: Error propagation and reporting
	 *
	 * Sets the icon of view.
	 *
	 */
	public abstract void set_view_icon_from_stock (MessageView view, string icon) throws Error;
}
