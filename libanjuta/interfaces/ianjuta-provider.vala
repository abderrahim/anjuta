/**
 * SECTION:ianjuta-provider
 * @title: IAnjutaProvider
 * @short_description: Provider for autocompletion features
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 */
public interface IAnjuta.Provider : Object
{
	/**
	 * ianjuta_provider_populate
	 * @self: Self
	 * @iter: the text iter where the provider should be populated
	 * @error: Error propagation and reporting.
	 *
	 * Show completion for the context at position @iter. The provider should
	 * call ianjuta_editor_assist_proposals here to add proposals to the list.
	 *
	 * Note that this is called after every character typed and the list of proposals
	 * has to be completely renewed.
	 */
	public abstract void populate(Iterable iter) throws Error;

	/**
	 * ianjuta_provider_get_start_iter
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Get the iter where the current completion started
	 *
	 * Returns: current start iter
	 */
	public abstract Iterable get_start_iter() throws Error;

	/**
	 * ianjuta_provider_activate
	 * @self: Self
	 * @iter: position where the completion occurs
	 * @data: data assigned to the proposal
	 * @error: Error propagation and reporting.
	 *
	 * Show completion for the context at position @iter
	 */
	public abstract void activate(Iterable iter, void* data) throws Error;

	/**
	 * ianjuta_provider_get_name
	 * @self: Self
	 *
	 * Return a (translatable) name for the provider
	 */
	public abstract unowned string get_name() throws Error;
}
