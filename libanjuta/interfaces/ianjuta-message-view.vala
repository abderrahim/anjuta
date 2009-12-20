/**
 * SECTION:ianjuta-message-view
 * @title: IAnjutaMessageView
 * @short_description: A view where messages of different kind can be shown
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */

/**
 * IAnjutaMessageViewType:
 * @IANJUTA_MESSAGE_VIEW_TYPE_NORMAL: Normal message
 * @IANJUTA_MESSAGE_VIEW_TYPE_INFO: Info message (highlighed)
 * @IANJUTA_MESSAGE_VIEW_TYPE_ERROR: Error message
 * @IANJUTA_MESSAGE_VIEW_TYPE_WARNING: Warning message
 *
 * Speficy the type ot the message added to the message view
 */
public enum IAnjuta.MessageViewType
{
	NORMAL,
	INFO,
	WARNING,
	ERROR
}

public interface IAnjuta.MessageView : Object
{

	/**
	 * IAnjutaMessageView::message-clicked:
	 * @self: Self
	 * @message: text of the clicked message
	 *
	 * Emitted when the user clicks on a message
	 */
	public virtual signal void message_clicked (string message);

	/**
	 * IAnjutaMessageView::buffer-flushed:
	 * @self: Self
	 * @line: the current line
	 *
	 * Emitted when #ianjuta_message_view_buffer_append found a newline
	 */
	public virtual signal void buffer_flushed (string line);

	/**
	 * ianjuta_message_view_buffer_append:
	 * @self: Self
	 * @text: text to show as message
	 * @error: Error propagation and reporting.
	 *
	 * Appends the text in buffer. Flushes the buffer where a newline is found.
	 * by emiiting buffer_flushed signal. The string is expected to be utf8.
	 */
	public abstract void buffer_append (string text) throws Error;

	/**
	 * ianjuta_message_view_append:
	 * @self: Self
	 * @type: type of the message
	 * @summary: summary of the message
	 * @details: details of the message
	 * @error: Error propagation and reporting.
	 *
	 * Append the message with summary displayed and details displayed as tooltip
	 */
	public abstract void append (Type type, string summary, string details) throws Error;

	/**
	 * ianjuta_message_view_clear:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Clear all messages in buffer
	 */
	public abstract void clear () throws Error;

	/**
	 * ianjuta_message_view_select_next:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Select next message (of type INFO, WARNING or ERROR)
	 */
	public abstract void select_next () throws Error;

	/**
	 * ianjuta_message_view_select_previous:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Select previous message
	 */
	public abstract void select_previous () throws Error;

	/**
	 * ianjuta_message_view_get_current_message:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Get the currently selected message
	 */
	public abstract unowned string get_current_message () throws Error;

	/**
	* ianjuta_message_view_get_all_messages:
	* @self: Self
	* @error: Error propagation and reporting.
	*
	* Get a list of all messages. The list has to be freed
	*/
	public abstract List<unowned string> get_all_messages () throws Error;
}
