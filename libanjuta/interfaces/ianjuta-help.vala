
/**
 * SECTION:ianjuta-help
 * @title: IAnjutaHelp
 * @short_description: Implemented by plugins that can provide help support
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.Help : Object
{
	/**
	 * ianjuta_help_search:
	 * @self: Self
	 * @query: string to search in the help
	 * @error: Error propagation and reporting
	 *
	 * Search for string @query in the help and display the result
	 */
	public abstract void search (string query) throws Error;
}
